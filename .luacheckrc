-- Luacheck configuration for Neovim Lua plugin
std = "luajit"
cache = true

-- Neovim globals (writable because plugins set vim.bo, vim.wo, vim.o, vim.opt, etc.)
globals = {
  "vim",
}

-- Plenary test globals
files["tests/**/*_spec.lua"] = {
  read_globals = {
    "describe",
    "it",
    "before_each",
    "after_each",
    "setup",
    "teardown",
    "pending",
    "assert",
  },
}

ignore = {
  "211", -- unused variable (common in Lua for destructuring: local ok, _ = pcall(...))
  "212", -- unused argument (common in callbacks and interface implementations)
  "231", -- variable set but never accessed (common in test setup)
  "311", -- value assigned to variable is unused (common with reassignment patterns)
  "542", -- empty if branch (intentional placeholder patterns)
  "611", -- line contains only whitespace (handled by stylua/editorconfig)
  "612", -- line contains trailing whitespace (handled by stylua/editorconfig)
  "614", -- trailing whitespace in comment (handled by stylua/editorconfig)
  "631", -- max_line_length (handled by stylua)
}

-- Catch real errors: redefined variables, accessing undefined globals, etc.
-- Warnings still enabled: 111 (setting non-standard globals), 112 (mutating read-only globals),
-- 113 (accessing undefined variables), 121-122 (setting/mutating read-only globals),
-- 411 (variable redefining), 421 (shadowing local), 431 (shadowing upvalue)
