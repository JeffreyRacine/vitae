Curriculum Vitae (HTML-first workflow)

Overview

- This repository contains the source for the CV (`index.qmd`) and supporting assets (CSS, bibliographies, icons).
- The preferred workflow is HTML-first: render the QMD to HTML with Quarto and print the HTML to PDF using a headless browser (Google Chrome).

Quick commands

- Render HTML:

    quarto render index.qmd

- Print the rendered HTML to PDF (macOS example):

    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf="index.pdf" "index.html"

- Render with a different spacing preset (example, body line-height = 1.15):

    quarto render index.qmd -P spacing.value.body_line_height=1.15
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf="index_spacing_115.pdf" "index.html"

Notes

- Spacing parameters are controlled in the YAML `params.spacing.value` map. Adjust `body_line_height`, `bib_line_height`, and other spacing variables there and re-render to see the effect.
- The `cv.css` file centralizes spacing via CSS custom properties — the README and Makefile are intentionally minimal; modify them for your environment or CI.

Support

If you want, I can add additional Makefile targets (e.g., `preview`, `ci`, or spacing presets) or add a short CI job that renders PDFs for a set of presets.