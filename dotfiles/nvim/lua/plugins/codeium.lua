-- ~/.config/nvim/lua/plugins/coding/codeium.lua
return {
  "Exafunction/windsurf.vim",
  -- Load after startup, but not immediately blocking UI
  event = "VeryLazy",
  -- You can uncomment the 'enabled = false' line if you want
  -- it to be disabled by default and enable it manually later
  -- enabled = false,
  config = function()
    -- Codeium primarily uses global variables for configuration.
    -- Set them *before* the plugin loads using vim.g
    -- Example: Disable initial automatic suggestions if you prefer manual trigger
    -- vim.g.codeium_disable_bindings = 1 -- Set to 1 to disable default keybindings

    -- You can set other vim.g.codeium_ options here if needed.
    -- Refer to :help codeium for available options.

    -- Example keymaps (customize these keys as needed!)
    -- It's often recommended to disable default bindings (vim.g.codeium_disable_bindings = 1)
    -- and set your own explicit ones to avoid conflicts, especially with Tab.

    -- Accept suggestion (use a key other than Tab if it conflicts with completion/snippets)
    vim.keymap.set("i", "<C-g>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, desc = "Codeium: Accept Suggestion" })
    -- You could try mapping Tab, but be aware of potential conflicts:
    -- vim.keymap.set("i", "<Tab>", function() return vim.fn["codeium#Accept"]() end, { expr = true, desc = "Codeium: Accept Suggestion" })

    -- Cycle through suggestions
    vim.keymap.set("i", "<M-]>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true, desc = "Codeium: Next Suggestion" })
    vim.keymap.set("i", "<M-[>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true, desc = "Codeium: Previous Suggestion" })

    -- Clear suggestion
    vim.keymap.set("i", "<C-x>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true, desc = "Codeium: Clear Suggestion" })

    -- Manually trigger suggestion (optional)
    -- vim.keymap.set("i", "<C-/>", function() return vim.fn["codeium#Complete"]() end, { expr = true, desc = "Codeium: Trigger Suggestion" })

    -- Normal mode mappings for commands (using <leader>c as prefix example)
    vim.keymap.set("n", "<leader>ce", ":CodeiumEnable<CR>", { desc = "Codeium: Enable" })
    vim.keymap.set("n", "<leader>cd", ":CodeiumDisable<CR>", { desc = "Codeium: Disable" })
    vim.keymap.set("n", "<leader>ca", ":CodeiumAuth<CR>", { desc = "Codeium: Authenticate" })
    vim.keymap.set("n", "<leader>cs", ":CodeiumStatus<CR>", { desc = "Codeium: Status" })
  end,
}
