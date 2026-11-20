#!/usr/bin/env bash
set -euo pipefail

skill_dir=$(cd "$(dirname "$0")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

cat > "$tmp/two-column.md" <<'EOF'
---
twocolumn: true
---

| Item | Detail |
| --- | --- |
| One | Example |

: Test caption
EOF

pandoc "$tmp/two-column.md" --lua-filter="$skill_dir/filters/tables.lua" -t latex > "$tmp/two-column.tex"
grep -Fq '\begin{table*}' "$tmp/two-column.tex"
grep -Fq '\begin{tabularx}' "$tmp/two-column.tex"
grep -Fq '\caption{Test caption}' "$tmp/two-column.tex"

sed 's/twocolumn: true/twocolumn: false/' "$tmp/two-column.md" > "$tmp/one-column.md"
pandoc "$tmp/one-column.md" --lua-filter="$skill_dir/filters/tables.lua" -t latex > "$tmp/one-column.tex"
grep -Fq '\begin{longtable}' "$tmp/one-column.tex"
! grep -Fq '\begin{table*}' "$tmp/one-column.tex"
