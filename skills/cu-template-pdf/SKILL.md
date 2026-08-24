---
name: cu-template-pdf
description: Creates Coventry University-branded PDFs from Markdown using the bundled CU template. Use when a user asks to turn a Markdown document into a CU-templated PDF, or needs Pandoc/XeLaTeX setup and build instructions.
---

# CU templated PDF

Use the template and assets in this skill; do not look for the original Delivery Materials folder at runtime.

## Build

From the skill directory, run:

```bash
./scripts/build-pdf.sh /absolute/path/to/document.md
```

The script writes a PDF beside the Markdown file. Supply a second argument to choose the output path:

```bash
./scripts/build-pdf.sh document.md output.pdf
```

The Markdown should normally include Pandoc YAML metadata such as:

```yaml
---
title: "Document title"
subtitle: "Optional subtitle"
author: "Optional author"
date: "Optional date"
lang: en-GB
---
```

Use ordinary Markdown headings, lists, tables, links, and emphasis. Raw LaTeX such as `\vspace{8mm}` is supported by the build.

## Tool setup

Check the current machine before building:

```bash
command -v pandoc && pandoc --version | head -3
command -v xelatex
```

If either command is missing, install the smallest suitable toolchain:

- macOS with Homebrew: `brew install pandoc` and `brew install --cask mactex`
- Debian/Ubuntu: `sudo apt-get install pandoc texlive-xetex`

After installing MacTeX, restart the shell if `xelatex` is not yet on `PATH`. The script uses `PDF_ENGINE` when set, otherwise `xelatex`:

```bash
PDF_ENGINE=xelatex ./scripts/build-pdf.sh document.md
```

Do not replace the bundled template with a generic Pandoc PDF unless the user explicitly asks for an unbranded document. If the build fails, inspect the Pandoc/XeLaTeX error first; common causes are missing fonts/packages, invalid raw LaTeX, or unsupported Markdown syntax.

## What the build does

`scripts/build-pdf.sh` runs Pandoc with:

- `templates/cu-template.tex` as the LaTeX template
- `xelatex` as the PDF engine
- the Markdown file as input
- the Markdown directory and bundled asset directory as resource paths

The template adds the CU title page, colours, typography, page numbers, branded background, logo, and closing page. Keep `templates/assets/background-image.pdf` and `templates/assets/cu-logo.pdf` with the template.
