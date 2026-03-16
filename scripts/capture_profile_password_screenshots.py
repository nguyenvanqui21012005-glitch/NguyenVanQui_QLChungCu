import argparse
import os
import re
import time
import unicodedata
from pathlib import Path
from urllib.parse import urljoin

from playwright.sync_api import sync_playwright


def _slugify(text: str) -> str:
    t = (text or "").strip().lower()
    t = unicodedata.normalize("NFKD", t)
    t = "".join(c for c in t if not unicodedata.combining(c))
    t = re.sub(r"[^a-z0-9]+", "-", t).strip("-")
    return t or "page"


def _next_index(folder: Path) -> int:
    if not folder.exists():
        folder.mkdir(parents=True, exist_ok=True)
        return 1
    max_idx = 0
    for p in folder.glob("*.png"):
        m = re.match(r"^(\d+)-", p.name)
        if not m:
            continue
        try:
            max_idx = max(max_idx, int(m.group(1)))
        except Exception:
            continue
    return max_idx + 1


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--base-url", default=os.environ.get("BASE_URL", "http://localhost:8000"))
    parser.add_argument("--username", default=os.environ.get("DJANGO_USERNAME", "admin"))
    parser.add_argument("--password", default=os.environ.get("DJANGO_PASSWORD", "Admin@123"))
    parser.add_argument(
        "--out-dir",
        default=os.environ.get(
            "OUT_DIR",
            str(Path("scripts") / "screenshots" / "20260315-235530"),
        ),
    )
    parser.add_argument("--headless", action=argparse.BooleanOptionalAction, default=True)
    parser.add_argument("--full-page", action=argparse.BooleanOptionalAction, default=True)
    parser.add_argument("--timeout-ms", type=int, default=20000)
    parser.add_argument("--wait-ms", type=int, default=700)
    args = parser.parse_args()

    base_url = args.base_url.rstrip("/") + "/"
    out_dir = Path(args.out_dir)
    idx = _next_index(out_dir)

    targets = [
        ("Profile", urljoin(base_url, "profile/")),
        ("Doi mat khau", urljoin(base_url, "profile/change-password/")),
    ]

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=bool(args.headless))
        context = browser.new_context(viewport={"width": 1440, "height": 900})
        page = context.new_page()
        page.set_default_timeout(int(args.timeout_ms))

        page.goto(urljoin(base_url, "login/"), wait_until="domcontentloaded")
        page.locator('input[name="username"]').fill(args.username)
        page.locator('input[name="password"]').fill(args.password)
        page.locator('button[type="submit"]').click()
        page.wait_for_load_state("domcontentloaded")
        if "/login" in page.url:
            raise RuntimeError("Login failed. Check username/password.")

        for label, url in targets:
            page.goto(url, wait_until="domcontentloaded")
            page.wait_for_timeout(int(args.wait_ms))
            file_path = out_dir / f"{idx:02d}-{_slugify(label)}.png"
            page.screenshot(path=str(file_path), full_page=bool(args.full_page))
            idx += 1

        browser.close()

    print(f"Saved screenshots to: {out_dir}")


if __name__ == "__main__":
    main()

