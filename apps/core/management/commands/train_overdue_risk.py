from pathlib import Path

from django.conf import settings
from django.core.management.base import BaseCommand
from django.db.models import Prefetch
from django.utils import timezone

from apps.fees.models import Invoice, Payment
from apps.reports.overdue_risk import build_overdue_risk_features


class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument("--max-invoices", type=int, default=8000)
        parser.add_argument("--min-train", type=int, default=200)
        parser.add_argument("--test-ratio", type=float, default=0.2)
        parser.add_argument("--output", type=str, default="")
        parser.add_argument("--meta-output", type=str, default="")

    def handle(self, *args, **options):
        try:
            from sklearn.feature_extraction import DictVectorizer
            from sklearn.linear_model import LogisticRegression
            from sklearn.metrics import classification_report, roc_auc_score
            from sklearn.pipeline import Pipeline
            from sklearn.preprocessing import StandardScaler
        except Exception as e:
            raise RuntimeError(
                "Thiếu dependency ML. Hãy cài scikit-learn (pip install -r requirements.txt)."
            ) from e

        today = timezone.localdate()

        qs = (
            Invoice.objects.exclude(status=Invoice.Status.CANCELLED)
            .select_related("fee_type", "apartment__floor", "resident")
            .prefetch_related(Prefetch("payments", queryset=Payment.objects.only("amount_paid", "paid_at")))
            .order_by("due_date", "pk")
        )
        max_invoices = int(options["max_invoices"])
        if max_invoices:
            qs = qs[:max_invoices]
        invoices = list(qs)

        rows = build_overdue_risk_features(invoices, today=today)
        X = [feat for (_, feat, y) in rows if y is not None]
        y = [y for (_, _, y) in rows if y is not None]

        if len(y) < int(options["min_train"]):
            self.stdout.write(
                self.style.ERROR(
                    f"Không đủ dữ liệu train. Cần >= {options['min_train']} invoice đã qua hạn, hiện có {len(y)}."
                )
            )
            return

        test_ratio = float(options["test_ratio"])
        test_size = max(1, int(len(y) * test_ratio))
        train_size = len(y) - test_size
        if train_size < 50:
            test_size = max(1, len(y) - 50)
            train_size = len(y) - test_size

        X_train, y_train = X[:train_size], y[:train_size]
        X_test, y_test = X[train_size:], y[train_size:]

        model = Pipeline(
            steps=[
                ("vec", DictVectorizer(sparse=True)),
                ("scale", StandardScaler(with_mean=False)),
                ("clf", LogisticRegression(max_iter=2000, class_weight="balanced")),
            ]
        )
        model.fit(X_train, y_train)

        proba = model.predict_proba(X_test)[:, 1]
        pred = (proba >= 0.5).astype(int)

        auc = roc_auc_score(y_test, proba) if len(set(y_test)) > 1 else 0.0
        self.stdout.write(self.style.SUCCESS(f"Train size: {len(y_train)} | Test size: {len(y_test)}"))
        self.stdout.write(self.style.SUCCESS(f"ROC-AUC: {auc:.4f}"))
        self.stdout.write(classification_report(y_test, pred, digits=4))

        out_arg = (options.get("output") or "").strip()
        if out_arg:
            out_path = Path(out_arg)
        else:
            out_path = Path(settings.BASE_DIR) / "ml_models" / "overdue_risk.joblib"
        out_path.parent.mkdir(parents=True, exist_ok=True)

        try:
            import joblib
        except Exception as e:
            raise RuntimeError("Thiếu joblib (đi kèm scikit-learn).") from e

        joblib.dump(model, out_path)
        self.stdout.write(self.style.SUCCESS(f"Saved model: {out_path}"))

        tn = fp = fn = tp = 0
        for yt, yp in zip(y_test, pred, strict=False):
            if yt == 0 and yp == 0:
                tn += 1
            elif yt == 0 and yp == 1:
                fp += 1
            elif yt == 1 and yp == 0:
                fn += 1
            else:
                tp += 1

        top_positive = []
        top_negative = []
        try:
            vec = model.named_steps["vec"]
            clf = model.named_steps["clf"]
            names = list(vec.get_feature_names_out())
            weights = list(clf.coef_[0])
            pairs = list(zip(names, weights, strict=False))
            pairs_sorted = sorted(pairs, key=lambda x: x[1], reverse=True)
            top_positive = [{"feature": n, "weight": float(w)} for (n, w) in pairs_sorted[:12]]
            top_negative = [{"feature": n, "weight": float(w)} for (n, w) in pairs_sorted[-12:][::-1]]
        except Exception:
            top_positive = []
            top_negative = []

        meta_arg = (options.get("meta_output") or "").strip()
        if meta_arg:
            meta_path = Path(meta_arg)
        else:
            meta_path = out_path.with_suffix(".json")

        payload = {
            "trained_at": timezone.now().isoformat(),
            "train_size": len(y_train),
            "test_size": len(y_test),
            "roc_auc": float(auc),
            "confusion_matrix": {"tn": tn, "fp": fp, "fn": fn, "tp": tp},
            "top_positive": top_positive,
            "top_negative": top_negative,
        }

        import json

        meta_path.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")
        self.stdout.write(self.style.SUCCESS(f"Saved meta: {meta_path}"))
