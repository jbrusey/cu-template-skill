---
name: cu-template-pdf-install-windows
description: Installs Pandoc and a XeLaTeX provider on Windows for the cu-template-pdf skill. Use when a Windows machine is missing pandoc or xelatex.
---

# Install CU PDF tools on Windows

Install Pandoc and MiKTeX with WinGet:

```powershell
winget install --id JohnMacFarlane.Pandoc -e
winget install --id MiKTeX.MiKTeX -e
```

Restart PowerShell, then verify:

```powershell
pandoc --version
xelatex --version
```

MiKTeX may ask permission to install missing LaTeX packages during the first PDF build. TeX Live for Windows also provides `xelatex` if the user prefers it.
