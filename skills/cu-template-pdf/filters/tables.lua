local function latex(inlines)
  local doc = pandoc.Pandoc({pandoc.Plain(inlines)})
  return pandoc.write(doc, "latex"):gsub("\n", " ")
end

-- shortcut: simple inline cells only; extend this if tables need spans or block content.
local function cell_text(cell)
  if cell.row_span > 1 or cell.col_span > 1 then
    error("Two-column tables do not support row or column spans yet")
  end

  local parts = {}
  for _, block in ipairs(cell.contents) do
    if block.t == "Plain" or block.t == "Para" then
      parts[#parts + 1] = latex(block.content)
    else
      error("Two-column table cells currently support inline content only")
    end
  end
  return table.concat(parts, [[\\]])
end

local function render_rows(rows, bold)
  local out = {}
  for _, row in ipairs(rows) do
    local cells = {}
    for _, cell in ipairs(row.cells) do
      local value = cell_text(cell)
      if bold then value = "\\textbf{" .. value .. "}" end
      cells[#cells + 1] = value
    end
    out[#out + 1] = table.concat(cells, " & ") .. [[ \\]]
  end
  return table.concat(out, "\n")
end

local is_two_column = false

function Table(tbl)
  if not is_two_column then return nil end

  local column_spec = string.rep("X", #tbl.colspecs)
  local out = { "\\begin{table*}[t]", "\\centering" }
  if #tbl.caption.long > 0 then
    out[#out + 1] = "\\caption{" .. latex(tbl.caption.long[1].content or {}) .. "}"
  end
  out[#out + 1] = "\\begin{tabularx}{\\textwidth}{" .. column_spec .. "}"
  out[#out + 1] = "\\toprule"
  if #tbl.head.rows > 0 then
    out[#out + 1] = render_rows(tbl.head.rows, true)
    out[#out + 1] = "\\midrule"
  end
  for _, body in ipairs(tbl.bodies) do
    out[#out + 1] = render_rows(body.head, false)
    out[#out + 1] = render_rows(body.body, false)
  end
  out[#out + 1] = "\\bottomrule"
  out[#out + 1] = "\\end{tabularx}"
  out[#out + 1] = "\\end{table*}"
  return pandoc.RawBlock("latex", table.concat(out, "\n"))
end

function Pandoc(doc)
  is_two_column = doc.meta.twocolumn == true
  return doc:walk({ Table = Table })
end
