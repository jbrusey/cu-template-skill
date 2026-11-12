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

Use absolute paths for the bundled template and assets so the command works from any current directory. Set `SKILL_DIR` to the directory containing this `SKILL.md` (from the skill location shown when it was loaded), then replace the document paths below. Include the document's directory in `--resource-path` so relative images still resolve. On macOS/Linux, separate resource paths with `:`:

```bash
SKILL_DIR="/absolute/path/to/skills/cu-template-pdf"
pandoc /absolute/path/to/document.md --template="$SKILL_DIR/templates/cu-template.tex" --pdf-engine=xelatex --resource-path="/absolute/path/to:$SKILL_DIR/templates/assets" -o /absolute/path/to/document.pdf
```

In Windows PowerShell, set the same directory and separate resource paths with `;`:

```powershell
$SkillDir = 'C:\path\to\skills\cu-template-pdf'
pandoc C:\path\to\document.md --template="$SkillDir\templates\cu-template.tex" --pdf-engine=xelatex "--resource-path=C:\path\to;$SkillDir\templates\assets" -o C:\path\to\document.pdf
```

The Markdown should normally include Pandoc YAML metadata:

```yaml
---
title: "Document title"
subtitle: "Optional subtitle"
author: "Optional author"
date: "Version 1.0"
lang: en-GB
sansfont: Helvetica
---
```

`sansfont` is optional; it changes the document's sans-serif typeface. For example, use `Helvetica` or `Linux Biolinum O`. The font must be installed and available to XeLaTeX. Omit it to keep the default typeface.

Use headings, lists, tables, links, images, and emphasis. Raw LaTeX such as `\vspace{8mm}` is supported. Set `twocolumn: true` in the YAML metadata for a two-column main body; the title page remains single-column.

Do not replace the bundled template with a generic Pandoc PDF unless the user asks for an unbranded document. If the build fails, inspect the Pandoc/XeLaTeX error for missing packages, fonts, invalid raw LaTeX, or unsupported Markdown.

The template adds the CU title page, colours, typography, page numbers, background image, logo, and closing page. Keep the files in `templates/assets/` with the template.
