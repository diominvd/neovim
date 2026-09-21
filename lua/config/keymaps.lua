-- Custom Mapping Function
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    if type(opts) == "string" then
      opts = { desc = opts }
    end
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---------- General ----------
map("n", "<leader>w", ":w<CR>", "Save buffer")
map("n", "<leader>W", ":wqa<CR>", "Save all and exit")
map("n", "<leader>qq", ":qa!<CR>", "Exit without saving")
map("n", "<leader>hk", function()
  vim.cmd.edit(vim.fn.fnameescape(vim.fn.stdpath("config") .. "/KEYBINDINGS.md"))
end, "Open keybinding reference")
map("n", "<leader>hh", ":noh<CR>", "Clear search highlight")

map({ "n", "v" }, "<leader>d", '"_d', "Delete to black hole")
map("n", "<leader>y", "yy", "Yank line")
map("v", "<leader>y", "y", "Yank selection")

---------- Windows ----------
map("n", "<C-h>", "<C-w>h", "Window left")
map("n", "<C-j>", "<C-w>j", "Window down")
map("n", "<C-k>", "<C-w>k", "Window up")
map("n", "<C-l>", "<C-w>l", "Window right")
map("n", "<C-q>", ":close<CR>", "Close window")

map("n", "<leader>sv", ":vsplit<CR>", "Vertical split")
map("n", "<leader>sh", ":split<CR>", "Horizontal split")

---------- Buffers ----------
map("n", "<S-h>", function()
  require("bufferline").cycle(-1)
end, "Previous buffer")
map("n", "<S-l>", function()
  require("bufferline").cycle(1)
end, "Next buffer")
map("n", "<S-x>", function()
  local buf = vim.fn.bufnr()
  if vim.fn.buflisted(vim.fn.bufnr("#")) == 1 then
    vim.cmd("buffer #")
  else
    vim.cmd("bprevious")
  end
  vim.cmd("bdelete! " .. buf)
end, "Close buffer")
map("n", "<S-p>", function()
  require("bufferline").toggle_pin()
end, "Pin buffer")
map("n", "<A-h>", function()
  require("bufferline").move(-1)
end, "Move buffer left")
map("n", "<A-l>", function()
  require("bufferline").move(1)
end, "Move buffer right")

---------- Editing ----------
map("v", "<", "<gv", "Indent left")
map("v", ">", ">gv", "Indent right")
map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")
-- Typing `---` inserts an em-dash in prose (text/tex/rst only — markdown
-- keeps `---` free for horizontal rules).
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if vim.list_contains({ "text", "tex", "rst" }, vim.bo[args.buf].filetype) then
      vim.keymap.set("i", "---", "—", { buffer = args.buf, desc = "Insert em-dash" })
    end
  end,
})

---------- Search (Telescope) ----------
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, "Find file")
map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, "Find text")
map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, "Find buffer")
map("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end, "Help tags")
map("n", "<leader>fw", function()
  require("telescope.builtin").grep_string()
end, "Find word")
map("n", "<leader>fo", function()
  require("telescope.builtin").oldfiles()
end, "Recent files")
map("n", "<leader>fk", function()
  require("telescope.builtin").keymaps()
end, "Keymaps")
map("n", "<leader>fs", ":AutoSession search<CR>", "Session search")

---------- Git ----------
map("n", "<leader>gc", function()
  require("telescope.builtin").git_commits()
end, "Git commits")
map("n", "<leader>gs", function()
  require("telescope.builtin").git_status()
end, "Git status")
map("n", "<leader>gl", function()
  require("telescope.builtin").git_branches()
end, "Git branches")

---------- Diagnostics ----------
map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
map("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, "Next error")
map("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, "Prev error")

---------- Formatting ----------
map("n", "<leader>fmt", function()
  require("conform").format({
    lsp_format = "fallback",
    async = false,
    timeout_ms = 1500,
  })
end, "Format buffer")
map("n", "<leader>uF", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  if vim.g.disable_autoformat then
    vim.notify("Auto-format on save disabled", vim.log.levels.WARN)
  else
    vim.notify("Auto-format on save enabled", vim.log.levels.INFO)
  end
end, "Toggle format on save")

---------- Terminal ----------
local function main_editor_win()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local config = vim.api.nvim_win_get_config(win)
    local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
    if config.relative == "" and not vim.tbl_contains({ "neo-tree", "snacks_terminal", "qf" }, ft) then
      return win
    end
  end
  return vim.api.nvim_get_current_win()
end

map("n", "<leader>t", function()
  require("snacks").terminal.toggle(nil, {
    win = {
      relative = "win",
      win = main_editor_win(),
    },
  })
end, "Toggle terminal")
map("n", "<leader>gg", function()
  if vim.fn.executable("lazygit") == 1 then
    require("snacks").lazygit({
      win = {
        position = "float",
        relative = "editor",
        row = 0,
        col = 0,
        width = 0,
        height = 0,
        border = "single",
      },
    })
  else
    vim.notify("lazygit is not installed", vim.log.levels.WARN, { title = "lazygit" })
  end
end, "Open lazygit")

map("n", "<leader>e", function()
  vim.cmd("Neotree toggle")
end, "Toggle file explorer")
map("n", "<leader>E", function()
  require("utils.neotree").collapse_to_root()
end, "Collapse explorer tree to root")
map("n", "<leader>mp", function()
  vim.cmd("RenderMarkdown toggle")
end, "Toggle Markdown Preview")

map("n", "<leader>Q", function()
  local auto_session = require("auto-session")
  auto_session.DeleteSession()
  vim.cmd("qa!")
end, "Delete session and quit")

---------- LSP ----------
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf

    map("n", "K", function()
      require("utils.hover").combined_hover({ focusable = true })
    end, { buffer = bufnr, desc = "Hover + diagnostics" })
    map("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP signature help" })
    map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
    map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Find references" })
    map("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
    map("n", "gy", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition" })
    map("n", "gI", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
    map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
    map("n", "<leader>ih", function()
      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
    end, { buffer = bufnr, desc = "Toggle inlay hints" })
  end,
})
