-- Habit rules for the coach: each looks at the recent keys (newest last) and
-- returns a finding { reason, tip } or nil. `reason` describes what happened
-- for the model; `tip` is the offline fallback, in the coach's voice.

local M = {}

-- How many times `key` repeats at the end of `keys` (same mode).
local function tail_run(keys, key)
  local n = 0
  for i = #keys, 1, -1 do
    if keys[i].key ~= key then
      break
    end
    n = n + 1
  end
  return n
end

local function last(keys)
  return keys[#keys]
end

M.list = {
  -- jjjjjj / kkkkk / hhhhh / llllll
  function(keys)
    local k = last(keys)
    if not k or not k.mode:match("^[nv]") or not ({ h = 1, j = 1, k = 1, l = 1 })[k.key] then
      return nil
    end
    local n = tail_run(keys, k.key)
    if n < 6 then
      return nil
    end
    local vertical = k.key == "j" or k.key == "k"
    return {
      reason = ("pressed `%s` %d times in a row in %s mode"):format(k.key, n, k.mode),
      tip = vertical
          and ("Братан, %d раз `%s` подряд — набери `%d%s`, прыгни `}`/`{` по абзацам, `]f` к следующей функции или `s` (flash) куда глаз смотрит."):format(n, k.key, n, k.key)
        or ("Братан, %d раз `%s` — по строке быстрее `f<символ>`/`t<символ>`, `w`/`b` по словам, `0`/`$` в начало и конец."):format(n, k.key),
    }
  end,

  -- wwwwww / bbbbbb
  function(keys)
    local k = last(keys)
    if not k or not k.mode:match("^[nv]") or (k.key ~= "w" and k.key ~= "b") then
      return nil
    end
    local n = tail_run(keys, k.key)
    if n < 6 then
      return nil
    end
    return {
      reason = ("pressed `%s` %d times to move across words"):format(k.key, n),
      tip = ("Братан, %d раз `%s` — прыгни прямо к символу: `f<символ>` или `s` и пара букв (flash)."):format(n, k.key),
    }
  end,

  -- xxxx
  function(keys)
    local k = last(keys)
    if not k or k.mode ~= "n" or k.key ~= "x" then
      return nil
    end
    local n = tail_run(keys, "x")
    if n < 4 then
      return nil
    end
    return {
      reason = ("deleted %d characters with `x` one by one"):format(n),
      tip = "Братан, не долби `x`: слово — `dw`/`daw`, до конца строки — `D`, внутри кавычек — `di\"`.",
    }
  end,

  -- arrow keys
  function(keys)
    local k = last(keys)
    if not k or not ({ ["<Up>"] = 1, ["<Down>"] = 1, ["<Left>"] = 1, ["<Right>"] = 1 })[k.key] then
      return nil
    end
    if tail_run(keys, k.key) < 4 then
      return nil
    end
    return {
      reason = ("used the arrow key %s repeatedly in %s mode"):format(k.key, k.mode),
      tip = "Братан, стрелки далеко от рук — выйди в normal (`<Esc>`) и ходи `hjkl` или прыжками (`s`, `f`, `}`).",
    }
  end,

  -- <BS><BS><BS>... in insert mode
  function(keys)
    local k = last(keys)
    if not k or k.mode ~= "i" or k.key ~= "<BS>" then
      return nil
    end
    local n = tail_run(keys, "<BS>")
    if n < 8 then
      return nil
    end
    return {
      reason = ("erased %d characters with backspace in insert mode"):format(n),
      tip = "Братан, `<C-w>` стирает слово целиком, `<C-u>` — до начала строки. Или выйди и сделай `ciw`.",
    }
  end,

  -- dd dd dd
  function(keys)
    local n = 0
    for i = #keys, 2, -2 do
      if keys[i].key == "d" and keys[i - 1].key == "d" and keys[i].mode == "n" then
        n = n + 1
      else
        break
      end
    end
    if n < 3 then
      return nil
    end
    return {
      reason = ("deleted %d lines with `dd` one at a time"):format(n),
      tip = ("Братан, `%ddd` удалит разом, а `dap` — весь абзац, `daf` — функцию целиком."):format(n),
    }
  end,
}

-- First finding among the rules, or nil.
function M.check(keys)
  for _, rule in ipairs(M.list) do
    local finding = rule(keys)
    if finding then
      return finding
    end
  end
end

return M
