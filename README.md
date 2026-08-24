# CU Template PDF Skill

A pi skill that turns Markdown into Coventry University-branded PDFs with Pandoc and XeLaTeX. The repository includes the LaTeX template and branding assets.

## Install in pi

Pi can install the repository directly:

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

Then ask:

```text
Use the cu-template-pdf skill to build a PDF from ./project.md.
```

The skill lives at `skills/cu-template-pdf/SKILL.md`. Agent Skills-compatible tools can copy that directory into their skills directory, for example:

```bash
cp -R skills/cu-template-pdf ~/.claude/skills/
```

## Install the PDF tools

You need Pandoc and a TeX distribution that provides `xelatex`.

### Windows

Install with WinGet:

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

Restart the shell if `xelatex` is not on `PATH`.

### Debian or Ubuntu

```bash
sudo apt-get install pandoc texlive-xetex
```

Check the installation:

```text
pandoc --version
xelatex --version
```

## Build without pi

From the repository root, build beside the Markdown file:

macOS/Linux:

```bash
./skills/cu-template-pdf/scripts/build-pdf.sh ./project.md
```

Windows PowerShell:

```powershell
.\skills\cu-template-pdf\scripts\build-pdf.ps1 .\project.md
```

Choose an output path by passing a second argument. Set `PDF_ENGINE` to use another compatible engine.

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
