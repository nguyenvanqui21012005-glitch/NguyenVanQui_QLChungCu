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


def _ts_dir(base: Path) -> Path:
    stamp = time.strftime("%Y%m%d-%H%M%S")
    out = base / stamp
    out.mkdir(parents=True, exist_ok=True)
    return out


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--base-url", default=os.environ.get("BASE_URL", "http://localhost:8000"))
    parser.add_argument("--username", default=os.environ.get("DJANGO_USERNAME", "admin"))
    parser.add_argument("--password", default=os.environ.get("DJANGO_PASSWORD", "Admin@123"))
    parser.add_argument("--out-dir", default=os.environ.get("OUT_DIR", str(Path("scripts") / "screenshots")))
    parser.add_argument("--headless", action=argparse.BooleanOptionalAction, default=True)
    parser.add_argument("--full-page", action=argparse.BooleanOptionalAction, default=True)
    parser.add_argument("--timeout-ms", type=int, default=20000)
    parser.add_argument("--wait-ms", type=int, default=700)
    args = parser.parse_args()

    base_url = args.base_url.rstrip("/") + "/"
    out_base = Path(args.out_dir)
    out_dir = _ts_dir(out_base)

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

        sidebar = page.locator("#sidebar")
        sidebar.wait_for(state="visible")

        links = page.locator("#sidebar a.sidebar-link")
        count = links.count()

        seen = set()
        items = []
        for i in range(count):
            a = links.nth(i)
            href = a.get_attribute("href") or ""
            label = (a.locator("span").first.text_content() or "").strip()
            url = urljoin(base_url, href.lstrip("/"))
            key = (url, label)
            if url in seen:
                continue
            seen.add(url)
            items.append((label, url))

        for idx, (label, url) in enumerate(items, start=1):
            page.goto(url, wait_until="domcontentloaded")
            page.wait_for_timeout(int(args.wait_ms))
            name = _slugify(label)
            file_path = out_dir / f"{idx:02d}-{name}.png"
            page.screenshot(path=str(file_path), full_page=bool(args.full_page))

        browser.close()

    print(f"Saved {len(items)} screenshots to: {out_dir}")


if __name__ == "__main__":
    main()

