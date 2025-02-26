-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local mc = require("multicursor-nvim")

mc.setup()

local set = vim.keymap.set

-- Add cursor above/below the main cursor.
set({ "n", "x" }, "<A-up>", function()
  mc.lineAddCursor(-1)
end)
set({ "n", "x" }, "<A-down>", function()
  mc.lineAddCursor(1)
end)

-- Add or skip adding a new cursor by matching word/selection
set({ "n", "x" }, "<A-n>", function()
  mc.matchAddCursor(1)
end)
set({ "n", "x" }, "<A-s>", function()
  mc.matchSkipCursor(1)
end)

-- Add all matches in the document
set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors)

-- Delete the main cursor.
set({ "n", "x" }, "<leader>x", mc.deleteCursor)

-- Add and remove cursors with control + left click.
set("n", "<c-leftmouse>", mc.handleMouse)
set("n", "<c-leftdrag>", mc.handleMouseDrag)
set("n", "<c-leftrelease>", mc.handleMouseRelease)

-- Easy way to add and remove cursors using the main cursor.
set({ "n", "x" }, "<c-q>", mc.toggleCursor)

-- Clone every cursor and disable the originals.
set({ "n", "x" }, "<leader><c-q>", mc.duplicateCursors)

set("n", "<A-esc>", function()
  if not mc.cursorsEnabled() then
    mc.enableCursors()
  elseif mc.hasCursors() then
    mc.clearCursors()
  else
    -- Default <esc> handler.
  end
end)

-- bring back cursors if you accidentally clear them
set("n", "<leader>gv", mc.restoreCursors)

-- Align cursor columns.
set("n", "<leader>ac", mc.alignCursors)

-- Customize how cursors look.
local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { link = "Cursor" })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorMatchPreview", { link = "Search" })
hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
