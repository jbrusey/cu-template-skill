---
name: cu-template-pdf-install-macos
description: Installs Pandoc and XeLaTeX on macOS for the cu-template-pdf skill. Use when a macOS machine is missing pandoc or xelatex.
---

# Install CU PDF tools on macOS

With Homebrew, install Pandoc and MacTeX:

```bash
brew install pandoc
brew install --cask mactex
```

Restart the shell if needed, then verify:

```bash
pandoc --version
xelatex --version
```
