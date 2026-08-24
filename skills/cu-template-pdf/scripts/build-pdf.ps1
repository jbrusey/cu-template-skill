param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$InputFile,
    [Parameter(Position = 1)]
    [string]$OutputFile
)

$ErrorActionPreference = "Stop"
$skillDir = (Resolve-Path (Join-Path $PSScriptRoot ".." )).Path
$inputPath = (Resolve-Path $InputFile).Path

if (-not $OutputFile) {
    $OutputFile = [IO.Path]::ChangeExtension($inputPath, ".pdf")
} else {
    $OutputFile = [IO.Path]::GetFullPath($OutputFile)
}

$pandoc = if ($env:PANDOC) { $env:PANDOC } else { "pandoc" }
$engine = if ($env:PDF_ENGINE) { $env:PDF_ENGINE } else { "xelatex" }

if (-not (Get-Command $pandoc -ErrorAction SilentlyContinue)) {
    throw "Pandoc was not found. Install it with: winget install --id JohnMacFarlane.Pandoc -e"
}
if (-not (Get-Command $engine -ErrorAction SilentlyContinue)) {
    throw "PDF engine '$engine' was not found. Install MiKTeX or TeX Live, then restart PowerShell."
}

New-Item -ItemType Directory -Force -Path ([IO.Path]::GetDirectoryName($OutputFile)) | Out-Null
$template = Join-Path $skillDir "templates\cu-template.tex"
$resources = "$(Split-Path $inputPath -Parent);$(Join-Path $skillDir 'templates\assets')"

& $pandoc $inputPath `
    "--template=$template" `
    "--pdf-engine=$engine" `
    "--resource-path=$resources" `
    "-o" $OutputFile

Write-Output "Created $OutputFile"
