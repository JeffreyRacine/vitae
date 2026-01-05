# README — index.qmd

🎯 **Purpose**

This repository builds the CV from `index.qmd` using Quarto. Rendering produces `index.html` (web) and `index.pdf` (print-ready PDF).

---

## 🔧 Prerequisites

- Quarto (https://quarto.org/) installed and on your PATH
- A TeX distribution (MacTeX / TeX Live) if you want to render PDF output
- Git (for the automated commit/push steps)

---

## ⚙️ Build & Preview

- Preview a live-reloading site for development:

  ```bash
  quarto preview
  ```

- Render HTML (and PDF if TeX is available):

  ```bash
  quarto render index.qmd
  ```

- Use the included Makefile targets:

  - `make` — renders `index.qmd` and opens `index.pdf` (uses Skim on macOS)
  - `make github` — renders, copies `index.pdf` to `vitae.pdf`, commits, and pushes (see `makefile` for details)
  - `make clean` — removes generated artifacts (`index.html`, `index.pdf`, `index.tex`, `index_files`)

- There is also a `CV.sh` script that automates render + git commit/push (used for cron automation). Use with caution.

---

## 📚 Publications & Citation

Publication data are stored in the `.bib` files (`publications-*.bib`) and citation style is in `numeric-ydnt.csl`. Edit/add references there and update `index.qmd` citations as needed.

---

## 🎨 Styling & Assets

- Custom stylesheet: `cv.css`
- Static assets and Quarto-generated support files live in `index_files/`.

Edit `index.qmd` for content changes; do not edit generated files (`index.html`, `index.pdf`, `index.tex`).

---

## 🛠 Troubleshooting

- "quarto: command not found": install Quarto and reopen the terminal
- PDF not generated: confirm a working TeX distribution is installed
- git push in `make github`/`CV.sh` may fail if credentials are not set; verify your Git config
- Automated scraping of Google Scholar (or similar services) may trigger HTTP 403 (Forbidden) errors or temporary blocks; avoid automated scraping, respect Terms of Service, and prefer official APIs or manual exports (e.g., export from Google Scholar profile) when updating publication data.

---

## 🚀 Deployment

Below are common options for publishing the website version (`index.html` + `index_files/`) automatically.

### GitHub Pages (recommended)

- Option A — Deploy from `docs/` on `main` branch:
  1. Add a GitHub Pages site in repository Settings → Pages → select `main`/`docs` folder.
  2. Add a CI workflow (example below) that runs on push to `main`, runs `quarto render --output-dir docs`, then uploads `docs/` to GitHub Pages.

- Option B — Deploy to `gh-pages` branch:
  1. Render site to a publish directory: `quarto render --output-dir site`.
  2. Use an action (e.g., `peaceiris/actions-gh-pages@v3`) to push `site/` to `gh-pages` branch.

### GitHub Actions example (deploy to `docs/`)

Create `.github/workflows/deploy.yml` with:

```yaml
name: Build and deploy site
on:
  push:
    branches: [ main ]

permissions:
  pages: write
  contents: read

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: quarto-dev/quarto-actions/setup-quarto@v2
        with:
          quarto-version: 'latest'
      - name: Render site to docs/
        run: quarto render --output-dir docs
      - name: Upload Pages artifact
        uses: actions/upload-pages-artifact@v1
        with:
          path: docs
  deploy:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        uses: actions/deploy-pages@v1
```

Notes: ensure `main` is replaced with your default branch name, and enable Pages in repository settings if needed.

### Alternative hosts

- Netlify: connect repository to Netlify and set build command `quarto render --output-dir docs` and publish directory `docs/`, or use Netlify CLI (`npm install -g netlify-cli`) with a `NETLIFY_AUTH_TOKEN` repo secret and `netlify deploy --prod --dir=docs`.
- Vercel and others: connect the repo and set the appropriate build command and output directory.

---

## 🕒 Automated updates (cron)

If you prefer to update the rendered CV automatically on a schedule, you can run the included `CV.sh` with cron (or another scheduler). The repository already includes a sample crontab header in `CV.sh`; adjust it to your environment as needed.

Example (run weekly on Sundays at 00:00):

```cron
0 0 * * 0 /opt/local/bin/bash -l -c 'source ~/.bashrc && cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/CV/ && /opt/local/bin/bash ./CV.sh > ~/CV_cron.log 2>&1'
```

Notes:
- Ensure environment variables, PATH, and Git credentials are available in non-interactive shells (source your profile or set them explicitly in the script).
- Be mindful that automated scraping of Google Scholar (or similar services) can trigger HTTP 403 errors or temporary blocks; prefer manual exports or official APIs to refresh publication data.

---

## ✅ Notes

- This README is intentionally brief. If you'd like more details (CI deployment, GitHub Pages steps, or alternate output formats), say which you'd prefer and I'll expand it.

---

File location: `README.md` (root of this project)
