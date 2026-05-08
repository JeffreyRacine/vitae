# README — index.qmd

🎯 **Purpose**

This repository builds the CV from `index.qmd` using Quarto. Rendering produces `index.html` (web) and `index.pdf` (print-ready PDF).

For the maintained production workflow, M2Studio scheduled render, iCloud
checkout role, and recommended crontab entry, see [OPERATIONS.md](OPERATIONS.md).

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
  - `make render` — renders `index.qmd` and copies `index.pdf` to `vitae.pdf`
  - `make publish-local` — runs `CV.sh` without pushing
  - `make publish` — runs `CV.sh` with `CV_PUSH=1`
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
- git push in `make publish`/`CV.sh` may fail if credentials are not set; verify your Git config
- Automated scraping of Google Scholar (or similar services) may trigger HTTP 403 (Forbidden) errors or temporary blocks; avoid automated scraping, respect Terms of Service, and prefer official APIs or manual exports (e.g., export from Google Scholar profile) when updating publication data.

---

## 🚀 Deployment

The public website is served by GitHub Pages from the rendered files committed to
this repository. GitHub Actions is not the preferred renderer for this project
because the Google Scholar citation refresh must run locally.

The maintained publication workflow is:

1. Render locally with Quarto.
2. Commit `index.qmd`, `cv.css`, `index.html`, `index.pdf`, `vitae.pdf`, and
   required static assets.
3. Push to GitHub.
4. Let GitHub Pages serve the committed static output.

See [OPERATIONS.md](OPERATIONS.md) for the M2Studio/iCloud production checkout
workflow used for weekly Google Scholar refreshes.

---

## 🕒 Automated updates (cron)

The maintained cron workflow and recommended M2Studio crontab entry are recorded
in [OPERATIONS.md](OPERATIONS.md). Keep that file as the source of truth for the
iCloud production checkout and weekly Google Scholar refresh.

---

## ✅ Notes

- This README is intentionally brief. If you'd like more details (CI deployment, GitHub Pages steps, or alternate output formats), say which you'd prefer and I'll expand it.

---

File location: `README.md` (root of this project)
