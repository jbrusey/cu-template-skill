# CU Template PDF Skill

A pi skill that turns Markdown documents into Coventry University-branded PDFs with Pandoc and XeLaTeX.

The repository includes the LaTeX template and its branding assets, so the skill does not depend on the original Delivery Materials folder.

## Install for pi

Install it globally:

```bash
git clone https://github.com/jbrusey/cu-template-skill.git ~/.pi/agent/skills/cu-template-skill
```

Or use a local checkout explicitly:

```bash
pi --skill /path/to/cu-template-skill/SKILL.md
```

For one project, place or clone the repository under that project's `.pi/skills/` directory. Restart pi after installing so it discovers the skill.

## Use the skill

Ask pi to create a CU-templated PDF from a Markdown file, for example:

```text
Use the cu-template-pdf skill to build a PDF from ./project.md.
```

With skill commands enabled, load it directly:

```text
/skill:cu-template-pdf ./project.md
```

The Markdown can include Pandoc YAML metadata:

```yaml
---
title: "Project title"
subtitle: "Optional subtitle"
author: "Author name"
date: "Version 1.0"
lang: en-GB
---
```

## Build without pi

Check the required tools:

```bash
command -v pandoc
command -v xelatex
```

Build a PDF beside the Markdown file:

```bash
./scripts/build-pdf.sh ./project.md
```

Choose an output path:

```bash
./scripts/build-pdf.sh ./project.md ./output/project.pdf
```

The script uses `templates/cu-template.tex`, the bundled assets, and `xelatex`. It also adds the Markdown directory to Pandoc's resource path so local images can be used.

## Install Pandoc and XeLaTeX

On macOS with Homebrew:

```bash
brew install pandoc
brew install --cask mactex
```

On Debian or Ubuntu:

```bash
sudo apt-get install pandoc texlive-xetex
```

If MacTeX installs but `xelatex` remains unavailable, restart the shell and check your `PATH`.

## Markdown features

Use Markdown headings, lists, tables, links, images, and emphasis. The template also supports raw LaTeX such as `\vspace{8mm}` for controlled spacing in forms.

The generated document includes a branded title page when the Markdown supplies a title, CU colours and typography, page numbers, a background image, the CU logo, and a branded closing page.
