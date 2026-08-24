---
name: cu-template-pdf-install-ubuntu
description: Installs Pandoc and XeLaTeX on Ubuntu for the cu-template-pdf skill. Use when an Ubuntu machine is missing pandoc or xelatex.
---

# Install CU PDF tools on Ubuntu

Install Pandoc and the XeLaTeX packages:

```bash
sudo apt-get update
sudo apt-get install pandoc texlive-xetex
```

Verify:

```bash
pandoc --version
xelatex --version
```
