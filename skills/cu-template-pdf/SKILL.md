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

Set `SKILL_DIR` to the directory containing this `SKILL.md` (from the skill location shown when it was loaded) and `DOC_DIR` to the directory containing the Markdown. The command works from any current directory. `--resource-path` locates Pandoc-managed images; `TEXINPUTS` lets XeLaTeX find both the template's relative branding assets and local files used by raw commands such as `\input{x}`. Keep document and output paths absolute. On macOS/Linux, separate search paths with `:`:

```bash
SKILL_DIR="/absolute/path/to/skills/cu-template-pdf"
DOC_DIR="/absolute/path/to/document-directory"
TEXINPUTS="$DOC_DIR:$SKILL_DIR:${TEXINPUTS:+$TEXINPUTS:}" pandoc "$DOC_DIR/document.md" --template="$SKILL_DIR/templates/cu-template.tex" --lua-filter="$SKILL_DIR/filters/tables.lua" --pdf-engine=xelatex --resource-path="$DOC_DIR:$SKILL_DIR/templates/assets" -o "$DOC_DIR/document.pdf"
```

In Windows PowerShell, set the same directories and separate search paths with `;`:

```powershell
$SkillDir = 'C:\path\to\skills\cu-template-pdf'
$DocDir = 'C:\path\to\document-directory'
$env:TEXINPUTS = "$DocDir;$SkillDir;$env:TEXINPUTS"
pandoc "$DocDir\document.md" --template="$SkillDir\templates\cu-template.tex" --lua-filter="$SkillDir\filters\tables.lua" --pdf-engine=xelatex "--resource-path=$DocDir;$SkillDir\templates\assets" -o "$DocDir\document.pdf"
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

Use headings, lists, tables, links, images, and emphasis. Raw LaTeX such as `\vspace{8mm}` is supported. Set `twocolumn: true` in the YAML metadata for a two-column main body; the title page remains single-column. In two-column mode, the bundled Lua filter turns Markdown tables into full-width `table*` floats. These tables cannot break across pages and may float to the top of a later page; row/column spans and block content inside cells are not supported. Without two-column mode, tables retain Pandoc's normal behavior.

Do not replace the bundled template with a generic Pandoc PDF unless the user asks for an unbranded document. If the build fails, inspect the Pandoc/XeLaTeX error for missing packages, fonts, invalid raw LaTeX, or unsupported Markdown.

The template adds the CU title page, colours, typography, page numbers, background image, logo, and closing page. Keep the files in `templates/assets/` with the template.
