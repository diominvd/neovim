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

local PROMPT = [[Ты — справочная система по Neovim. Пиши по-русски в официально-техническом
стиле: безлично, без обращений, без сленга и эмоций, как в документации.
Обнаружено неэффективное действие: %s.
Последние клавиши: %s. Режим: %s. Тип файла: %s. Строка под курсором: %s
Проверенная рекомендация: %s
Сформулируй рекомендацию для этой ситуации: 1–2 полных предложения, только
реальные команды Vim из рекомендации, без списков, нумерации и заголовков.
Пример ответа: «Курсор перемещался по одной строке. Для перехода на шесть строк
вниз используйте `6j`, к следующему абзацу — `}`.»]]

local function notify(text)
  vim.schedule(function()
    vim.notify(text, vim.log.levels.INFO, { title = "Coach" })
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
    local text = ok and type(data) == "table" and vim.trim(data.response or "") or ""
    if res.code ~= 0 or not ok then
      offline_until = os.time() + 600
      notify(finding.tip)
      return
    end
    -- A small model sometimes answers with a bare list item; keep the
    -- verified tip unless the answer reads like a sentence.
    local usable = #text >= 40 and not text:match("^%d+%.") and text:match("[%.!]%s*$")
    notify(usable and text or finding.tip)
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
  vim.notify("Coach " .. (M.config.enabled and "on" or "off"), vim.log.levels.INFO, { title = "Coach" })
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
  vim.on_key(on_key, vim.api.nvim_create_namespace("coach"))
  vim.api.nvim_create_user_command("Coach", M.toggle, { desc = "Toggle the habit coach" })
end

return M
