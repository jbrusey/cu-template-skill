---
name: cu-template-pdf
description: Creates Coventry University-branded PDFs from Markdown with the bundled template. Use when turning Markdown into a CU-templated PDF.
---

# CU templated PDF

Use the template and assets in this skill. Do not look for the original Delivery Materials folder.

## Check tools

The build needs `pandoc` and `xelatex`. If either is missing, load the installer skill for the current operating system:

- Windows: `/skill:cu-template-pdf-install-windows`
- macOS: `/skill:cu-template-pdf-install-macos`
- Ubuntu: `/skill:cu-template-pdf-install-ubuntu`

After installation, verify that both commands are on `PATH` before continuing.

## Build

Run the command from this skill's directory. Replace the input and output paths. On macOS/Linux, use `:` between resource paths:

```bash
pandoc /absolute/path/to/document.md --template=templates/cu-template.tex --pdf-engine=xelatex --resource-path="/absolute/path/to:templates/assets" -o /absolute/path/to/document.pdf
```

In Windows PowerShell, use `;` between resource paths:

```powershell
pandoc C:\path\to\document.md --template=templates/cu-template.tex --pdf-engine=xelatex '--resource-path=C:\path\to;templates\assets' -o C:\path\to\document.pdf
```

The Markdown should normally include Pandoc YAML metadata:

```yaml
---
title: "Document title"
subtitle: "Optional subtitle"
author: "Optional author"
date: "Version 1.0"
lang: en-GB
---
```

Use headings, lists, tables, links, images, and emphasis. Raw LaTeX such as `\vspace{8mm}` is supported.

Do not replace the bundled template with a generic Pandoc PDF unless the user asks for an unbranded document. If the build fails, inspect the Pandoc/XeLaTeX error for missing packages, fonts, invalid raw LaTeX, or unsupported Markdown.

The template adds the CU title page, colours, typography, page numbers, background image, logo, and closing page. Keep the files in `templates/assets/` with the template.
