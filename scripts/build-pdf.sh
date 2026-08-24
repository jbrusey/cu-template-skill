#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 INPUT.md [OUTPUT.pdf]" >&2
  exit 2
}

[[ $# -ge 1 && $# -le 2 ]] || usage

input=$(cd "$(dirname "$1")" && printf '%s/%s' "$PWD" "$(basename "$1")")
[[ -f "$input" ]] || { echo "Input not found: $input" >&2; exit 1; }

if [[ $# == 2 ]]; then
  output=$2
  [[ "$output" = /* ]] || output="$PWD/$output"
else
  output="${input%.md}.pdf"
fi

skill_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
pandoc_bin=${PANDOC:-pandoc}
engine=${PDF_ENGINE:-xelatex}

if ! command -v "$pandoc_bin" >/dev/null 2>&1; then
  cat >&2 <<'EOF'
Pandoc is required but was not found.
Install it with:
  macOS/Homebrew: brew install pandoc
  Debian/Ubuntu:  sudo apt-get install pandoc
EOF
  exit 1
fi

if ! command -v "$engine" >/dev/null 2>&1; then
  cat >&2 <<EOF
PDF engine '$engine' is required but was not found.
Install it with:
  macOS/Homebrew: brew install --cask mactex
  Debian/Ubuntu:  sudo apt-get install texlive-xetex
EOF
  exit 1
fi

mkdir -p "$(dirname "$output")"
cd "$skill_dir"
"$pandoc_bin" "$input" \
  --template="$skill_dir/templates/cu-pid-template.tex" \
  --pdf-engine="$engine" \
  --resource-path="$(dirname "$input"):$skill_dir/templates/assets" \
  -o "$output"
printf 'Created %s\n' "$output"
