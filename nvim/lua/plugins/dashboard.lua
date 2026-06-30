return {
  {
    "nvim-mini/mini.starter",
    opts = function(_, opts)
      local starter = require("mini.starter")

      local digits = {
        ["0"] = { " ██████╗ ", "██╔═████╗", "██║██╔██║", "████╔╝██║", "╚██╔╝ ██║", " ╚═╝  ╚═╝" },
        ["1"] = { " ██╗", "███║", "╚██║", " ██║", " ██║", " ╚═╝" },
        ["2"] = { "██████╗ ", "╚════██╗", " █████╔╝", "██╔═══╝ ", "███████╗", "╚══════╝" },
        ["3"] = { "██████╗ ", "╚════██╗", " █████╔╝", " ╚═══██╗", "██████╔╝", "╚═════╝ " },
        ["4"] = { "██╗  ██╗", "██║  ██║", "███████║", "╚════██║", "     ██║", "     ╚═╝" },
        ["5"] = { "███████╗", "██╔════╝", "███████╗", "╚════██║", "███████║", "╚══════╝" },
        ["6"] = { " ██████╗ ", "██╔════╝ ", "███████╗ ", "██╔═══██╗", "╚██████╔╝", " ╚═════╝ " },
        ["7"] = { "███████╗", "╚════██║", "    ██╔╝", "   ██╔╝ ", "  ██╔╝  ", "  ╚═╝   " },
        ["8"] = { " █████╗ ", "██╔══██╗", "╚█████╔╝", "██╔══██╗", "╚█████╔╝", " ╚════╝ " },
        ["9"] = { " █████╗ ", "██╔══██╗", "╚██████║", " ╚═══██║", " █████╔╝", " ╚════╝ " },
        [":"] = { "   ", "██╗", "╚═╝", "██╗", "╚═╝", "   " },
      }

      local function big_time(text)
        local rows = { "", "", "", "", "", "" }
        for i = 1, #text do
          local ch = text:sub(i, i)
          local glyph = digits[ch] or { "   ", "   ", "   ", "   ", "   ", "   " }
          for row = 1, 6 do
            rows[row] = rows[row] .. glyph[row] .. " "
          end
        end
        return rows
      end

      local function banner_lines()
        local lines = big_time(os.date("%I:%M:%S"))
        table.insert(lines, "")
        table.insert(lines, os.date("%A, %B %d, %Y"))
        table.insert(lines, "Oshan")
        return lines
      end

      vim.api.nvim_set_hl(0, "MiniStarterHeader", { bold = true })
      vim.api.nvim_set_hl(0, "MiniStarterFooter", { bold = true })
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "MiniStarterHeader", { bold = true })
          vim.api.nvim_set_hl(0, "MiniStarterFooter", { bold = true })
        end,
      })

      -- mini.starter only re-centers on VimResized (terminal resize) and
      -- BufEnter, so opening a split (e.g. a file-explorer panel) shrinks the
      -- starter window without triggering a recenter. WinResized covers that.
      vim.api.nvim_create_autocmd("WinResized", {
        callback = function()
          for _, win_id in ipairs(vim.v.event.windows or vim.api.nvim_list_wins()) do
            local buf_id = vim.api.nvim_win_get_buf(win_id)
            if vim.bo[buf_id].filetype == "ministarter" then
              starter.refresh(buf_id)
            end
          end
        end,
      })

      opts.evaluate_single = true
      opts.items = {
        { name = " ", action = "", section = "" },
      }
      opts.content_hooks = {
        starter.gen_hook.aligning("center", "center"),
      }
      opts.header = function()
        return table.concat(banner_lines(), "\n")
      end
      opts.footer = ""
    end,
  },
}
