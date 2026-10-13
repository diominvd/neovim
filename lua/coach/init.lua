-- coach: real-time habit tips. Every key goes into a short history; cheap
-- rules (coach.rules) spot inefficient patterns, and when one fires a small
-- local model (Ollama) rephrases the advice for what is on screen. Without
-- Ollama the rule's own tip is shown. Tips are rate-limited by `cooldown`.

local rules = require("coach.rules")

local M = {}

M.config = {
  enabled = true,
  model = "qwen2.5:1.5b",
  url = "http://127.0.0.1:11434/api/generate",
  cooldown = 90, -- seconds between tips
  history = 40, -- keys kept
}

local keys = {}
local last_tip = 0
local busy = false
local offline_until = 0 -- skip the model for a while after it failed

local PROMPT = [[Ты — наставник по Neovim, общаешься по-свойски, как братан, по-русски.
Пользователь только что сделал неэффективно: %s.
Последние клавиши: %s. Режим: %s. Тип файла: %s. Строка под курсором: %s
Проверенный совет: %s
Перефразируй совет под эту ситуацию: 1–2 коротких предложения, обращение «братан»,
только реальные команды Vim из совета, без вступлений и без markdown-заголовков.]]

local function notify(text)
  vim.schedule(function()
    vim.notify(text, vim.log.levels.INFO, { title = "Братан" })
  end)
end

local function ask_model(finding, ctx)
  local body = vim.json.encode({
    model = M.config.model,
    prompt = PROMPT:format(finding.reason, ctx.keys, ctx.mode, ctx.ft, ctx.line, finding.tip),
    stream = false,
    options = { num_predict = 90, temperature = 0.4 },
  })
  busy = true
  vim.system({ "curl", "-s", "--max-time", "20", M.config.url, "-d", body }, { text = true }, function(res)
    busy = false
    local ok, data = pcall(vim.json.decode, res.stdout or "")
    local text = ok and type(data) == "table" and data.response
    if res.code ~= 0 or not text or text:match("^%s*$") then
      offline_until = os.time() + 600
      notify(finding.tip)
      return
    end
    notify(vim.trim(text))
  end)
end

local function on_finding(finding)
  local now = os.time()
  if busy or now - last_tip < M.config.cooldown then
    return
  end
  last_tip = now
  local ctx = {
    keys = table.concat(vim.tbl_map(function(k) return k.key end, keys), " "),
    mode = vim.api.nvim_get_mode().mode,
    ft = vim.bo.filetype ~= "" and vim.bo.filetype or "none",
    line = vim.trim(vim.api.nvim_get_current_line()):sub(1, 120),
  }
  keys = {}
  if now < offline_until or vim.fn.executable("curl") == 0 then
    notify(finding.tip)
  else
    ask_model(finding, ctx)
  end
end

local function on_key(_, typed)
  if not M.config.enabled or not typed or typed == "" then
    return
  end
  local mode = vim.api.nvim_get_mode().mode
  if mode:match("^c") or vim.bo.buftype ~= "" then
    return -- command line and special buffers (pickers, terminals, trees)
  end
  table.insert(keys, { key = vim.fn.keytrans(typed), mode = mode:sub(1, 1) })
  if #keys > M.config.history then
    table.remove(keys, 1)
  end
  local finding = rules.check(keys)
  if finding then
    on_finding(finding)
  end
end

function M.toggle()
  M.config.enabled = not M.config.enabled
  vim.notify("Coach " .. (M.config.enabled and "on" or "off"), vim.log.levels.INFO, { title = "Братан" })
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
  vim.on_key(on_key, vim.api.nvim_create_namespace("coach"))
  vim.api.nvim_create_user_command("Coach", M.toggle, { desc = "Toggle the habit coach" })
end

return M
