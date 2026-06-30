local function make_transparent()
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "StatusLine",
    "StatusLineNC",
    "TabLineFill",
    "VertSplit",
    "WinSeparator",
    "EndOfBuffer",
  }

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
  end
end

make_transparent()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = make_transparent,
})

return {}
