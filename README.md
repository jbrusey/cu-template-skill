# CU Template PDF Skills

A set of pi skills for turning Markdown into Coventry University-branded PDFs with Pandoc and XeLaTeX. The main skill includes the LaTeX template and branding assets.

## Install in pi

Pi installs the package and discovers all four skills:

```bash
pi install git:github.com/jbrusey/cu-template-skill
```

Use `-l` for a project-local install:

```bash
pi install -l git:github.com/jbrusey/cu-template-skill
```

You can also ask a coding agent:

```text
Install https://github.com/jbrusey/cu-template-skill as a skill.
```

Use the main skill:

```text
Use the cu-template-pdf skill to build a PDF from ./project.md.
```

The package includes platform-specific setup skills. The main skill loads the appropriate one when `pandoc` or `xelatex` is missing:

- `cu-template-pdf-install-windows`
- `cu-template-pdf-install-macos`
- `cu-template-pdf-install-ubuntu`

## Install the PDF tools manually

You need Pandoc and a TeX distribution that provides `xelatex`.

### Windows

```powershell
winget install --id JohnMacFarlane.Pandoc -e
winget install --id MiKTeX.MiKTeX -e
```

Restart PowerShell after installation. MiKTeX may prompt to install missing LaTeX packages during the first build. TeX Live for Windows also works.

### macOS

```bash
brew install pandoc
brew install --cask mactex
```

### Ubuntu

```bash
sudo apt-get update
sudo apt-get install pandoc texlive-xetex
```

Check the installation with `pandoc --version` and `xelatex --version`.

## Build without pi

Run from `skills/cu-template-pdf/`, replacing the input and output paths.

macOS/Linux:

```bash
pandoc /absolute/path/to/project.md --template=templates/cu-template.tex --pdf-engine=xelatex --resource-path="/absolute/path/to:templates/assets" -o /absolute/path/to/project.pdf
```

Windows PowerShell:

```powershell
pandoc C:\path\to\project.md --template=templates/cu-template.tex --pdf-engine=xelatex '--resource-path=C:\path\to;templates\assets' -o C:\path\to\project.pdf
```

## Markdown input

Add Pandoc YAML metadata when you want a title page:

```yaml
---
title: "Project title"
subtitle: "Optional subtitle"
author: "Author name"
date: "Version 1.0"
lang: en-GB
---
```

Use headings, lists, tables, links, images, and emphasis. Raw LaTeX such as `\vspace{8mm}` is also supported. The output includes the CU title page, colours, typography, page numbers, background image, logo, and closing page.
