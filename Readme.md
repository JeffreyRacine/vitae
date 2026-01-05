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

---

## ✅ Notes

- This README is intentionally brief. If you'd like more details (CI deployment, GitHub Pages steps, or alternate output formats), say which you'd prefer and I'll expand it.

---

File location: `README.md` (root of this project)
