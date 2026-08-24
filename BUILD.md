# Build without pi

You need Pandoc and a TeX distribution that provides `xelatex`.

## Install the PDF tools

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

## Build

Run from `skills/cu-template-pdf/`, replacing the input and output paths.

macOS/Linux:

```bash
pandoc /absolute/path/to/project.md --template=templates/cu-template.tex --pdf-engine=xelatex --resource-path="/absolute/path/to:templates/assets" -o /absolute/path/to/project.pdf
```

Windows PowerShell:

```powershell
pandoc C:\path\to\project.md --template=templates/cu-template.tex --pdf-engine=xelatex '--resource-path=C:\path\to;templates\assets' -o C:\path\to\project.pdf
```
