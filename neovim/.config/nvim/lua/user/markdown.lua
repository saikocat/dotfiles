local M = {}

local function trim(s)
  return (s:gsub('^%s+', ''):gsub('%s+$', ''))
end

local function rtrim(s)
  return (s:gsub('%s+$', ''))
end

local function join_lines(lines)
  local result = {}

  for _, line in ipairs(lines) do
    line = trim(line)

    if line ~= '' then
      result[#result + 1] = line
    end
  end

  -- Physical line boundaries become exactly one space.
  return table.concat(result, ' ')
end

local function parse_list_item(line)
  local indent, marker, body = line:match '^(%s*)([-+*]%s+)(.*)$'

  if not indent then
    indent, marker, body = line:match '^(%s*)(%d+[.)]%s+)(.*)$'
  end

  if not indent then
    return nil
  end

  -- Include Markdown task checkbox in the prefix:
  --
  -- - [ ] foo
  -- - [x] bar
  local checkbox, rest = body:match '^(%[[ xX]%]%s+)(.*)$'

  if checkbox then
    marker = marker .. checkbox
    body = rest
  end

  return {
    indent = indent,
    marker = marker,
    body = body,
  }
end

local function fence_start(line)
  local run = line:match '^%s*(```+)'

  if run then
    return '`', #run
  end

  run = line:match '^%s*(~~~+)'

  if run then
    return '~', #run
  end

  return nil
end

local function fence_close(line, char, minimum)
  local run

  if char == '`' then
    run = line:match '^%s*(```+)%s*$'
  else
    run = line:match '^%s*(~~~+)%s*$'
  end

  return run and #run >= minimum
end

local function is_heading(line)
  return line:match '^%s*#+%s' or line:match '^%s*#+%s*$'
end

local function is_blockquote(line)
  return line:match '^%s*>'
end

local function is_tableish(line)
  -- Conservative on purpose: don't reflow lines containing pipes.
  return line:find('|', 1, true) ~= nil
end

local function is_rule(line)
  local compact = line:gsub('%s', '')

  return compact:match '^%-%-%-+$' or compact:match '^___+$' or compact:match '^%*%*%*+$' or line:match '^%s*=+%s*$'
end

local function is_indented_code(line)
  return line:match '^    ' or line:match '^\t'
end

local function is_structure(line)
  return is_heading(line) or is_blockquote(line) or is_tableish(line) or is_rule(line) or is_indented_code(line)
end

local function is_paragraph_boundary(line)
  return line:match '^%s*$' or fence_start(line) or parse_list_item(line) or is_structure(line)
end

local function parse(lines)
  local blocks = {}
  local i = 1

  while i <= #lines do
    local line = lines[i]

    -- Fenced code block.
    local fence_char, fence_len = fence_start(line)

    if fence_char then
      local raw = { line }
      local j = i + 1

      while j <= #lines do
        raw[#raw + 1] = lines[j]

        if fence_close(lines[j], fence_char, fence_len) then
          j = j + 1
          break
        end

        j = j + 1
      end

      blocks[#blocks + 1] = {
        kind = 'raw',
        lines = raw,
      }

      i = j
    elseif line:match '^%s*$' then
      blocks[#blocks + 1] = {
        kind = 'raw',
        lines = { line },
      }

      i = i + 1
    else
      local item = parse_list_item(line)

      if item then
        -- A list item is a paragraph with a protected prefix.
        local parts = { item.body }
        local j = i + 1

        local content_column = vim.fn.strdisplaywidth(item.indent .. item.marker)

        while j <= #lines do
          local next_line = lines[j]

          if
            next_line:match '^%s*$'
            or fence_start(next_line)
            or parse_list_item(next_line)
            or is_heading(next_line)
            or is_blockquote(next_line)
            or is_tableish(next_line)
            or is_rule(next_line)
          then
            break
          end

          -- Don't accidentally absorb deeply indented code
          -- belonging to the list item.
          local whitespace = next_line:match '^(%s*)' or ''

          if vim.fn.strdisplaywidth(whitespace) >= content_column + 4 then
            break
          end

          parts[#parts + 1] = next_line
          j = j + 1
        end

        blocks[#blocks + 1] = {
          kind = 'list',
          indent = item.indent,
          marker = item.marker,
          text = join_lines(parts),
        }

        i = j
      elseif is_structure(line) then
        blocks[#blocks + 1] = {
          kind = 'raw',
          lines = { line },
        }

        i = i + 1
      else
        -- Normal prose paragraph.
        local indent = line:match '^(%s*)' or ''
        local body = line:sub(#indent + 1)

        local parts = { body }
        local j = i + 1

        while j <= #lines and not is_paragraph_boundary(lines[j]) do
          parts[#parts + 1] = lines[j]
          j = j + 1
        end

        blocks[#blocks + 1] = {
          kind = 'paragraph',
          indent = indent,
          text = join_lines(parts),
        }

        i = j
      end
    end
  end

  return blocks
end

local function append(result, lines)
  for _, line in ipairs(lines) do
    result[#result + 1] = line
  end
end

local function wrap_text(text, width, first_prefix, next_prefix)
  if text == '' then
    return { rtrim(first_prefix) }
  end

  local words = {}
  local separators = {}
  local pos = 1

  -- Keep whitespace that already exists *inside* a physical line.
  -- Only whitespace at physical line boundaries was normalized by
  -- join_lines().
  while true do
    local start_pos, end_pos = text:find('%S+', pos)

    if not start_pos then
      break
    end

    words[#words + 1] = text:sub(start_pos, end_pos)

    local next_nonspace = text:find('%S', end_pos + 1)

    if not next_nonspace then
      break
    end

    separators[#words] = text:sub(end_pos + 1, next_nonspace - 1)

    pos = next_nonspace
  end

  local result = {}
  local prefix = first_prefix
  local current = words[1] or ''

  for index = 2, #words do
    local separator = separators[index - 1] or ' '

    local candidate = current .. separator .. words[index]

    if current ~= '' and vim.fn.strdisplaywidth(prefix .. candidate) > width then
      result[#result + 1] = prefix .. current

      prefix = next_prefix
      current = words[index]
    else
      current = candidate
    end
  end

  result[#result + 1] = prefix .. current

  return result
end

local function get_wrap_width(bufnr, override)
  if override then
    return override
  end

  -- 1. Real buffer textwidth
  local textwidth = vim.bo[bufnr].textwidth

  if textwidth > 0 then
    return textwidth
  end

  -- 2. Fall back to colorcolumn, e.g. "80"
  --
  -- Ignore relative forms like "+1" because with textwidth=0
  -- they don't give us an absolute wrapping width.
  local colorcolumn = vim.wo.colorcolumn

  for entry in colorcolumn:gmatch '[^,]+' do
    local column = tonumber(entry)

    if column and column > 0 then
      return column
    end
  end

  -- 3. Fall back to wrapmargin
  local wrapmargin = vim.bo[bufnr].wrapmargin

  if wrapmargin > 0 then
    local width = vim.api.nvim_win_get_width(0) - wrapmargin

    if width > 0 then
      return width
    end
  end

  return nil
end

-- Unwrap
function M.unwrap(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local blocks = parse(lines)
  local result = {}

  for _, block in ipairs(blocks) do
    if block.kind == 'raw' then
      append(result, block.lines)
    elseif block.kind == 'paragraph' then
      result[#result + 1] = block.indent .. block.text
    elseif block.kind == 'list' then
      result[#result + 1] = block.indent .. block.marker .. block.text
    end
  end

  local view = vim.fn.winsaveview()

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, result)

  vim.fn.winrestview(view)
end

-- Wrap
function M.wrap(bufnr, width)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  width = get_wrap_width(bufnr, width)

  if not width then
    vim.notify('WrapMarkdown: no textwidth/colorcolumn/wrapmargin configured', vim.log.levels.WARN)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local blocks = parse(lines)
  local result = {}

  for _, block in ipairs(blocks) do
    if block.kind == 'raw' then
      append(result, block.lines)
    elseif block.kind == 'paragraph' then
      append(result, wrap_text(block.text, width, block.indent, block.indent))
    elseif block.kind == 'list' then
      local first_prefix = block.indent .. block.marker

      local continuation_prefix = block.indent .. string.rep(' ', vim.fn.strdisplaywidth(block.marker))

      append(result, wrap_text(block.text, width, first_prefix, continuation_prefix))
    end
  end

  local view = vim.fn.winsaveview()

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, result)

  vim.fn.winrestview(view)
end

-- Setup
function M.setup(bufnr)
  bufnr = bufnr or 0

  vim.api.nvim_buf_create_user_command(bufnr, 'UnwrapMarkdown', function()
    M.unwrap(bufnr)
  end, {
    desc = 'Unwrap Markdown paragraphs and list items',
  })

  vim.api.nvim_buf_create_user_command(bufnr, 'WrapMarkdown', function(opts)
    local width = nil

    if opts.args ~= '' then
      width = tonumber(opts.args)

      if not width or width <= 0 then
        vim.notify('WrapMarkdown: width must be a positive number', vim.log.levels.ERROR)
        return
      end
    end

    M.wrap(bufnr, width)
  end, {
    nargs = '?',
    desc = 'Wrap Markdown to textwidth or optional width',
  })
end

return M
