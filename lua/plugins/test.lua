return {
  {
    "vim-test/vim-test",
    keys = {
      { "t<C-c>", "<cmd>TestClass<cr>",   desc = "Class" },
      { "t<C-f>", "<cmd>TestFile<cr>",    desc = "File" },
      { "t<C-l>", "<cmd>TestLast<cr>",    desc = "Last" },
      { "t<C-n>", "<cmd>TestNearest<cr>", desc = "Nearest" },
      { "t<C-s>", "<cmd>TestSuite<cr>",   desc = "Suite" },
      { "t<C-v>", "<cmd>TestVisit<cr>",   desc = "Visit" },
    },
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#start_normal"] = 0
      vim.g["test#neovim#term_position"] = "vert  botright 60"
      vim.g["test#preserve_screen"] = 0
      vim.g["test#neovim_sticky#kill_previous"] = 1
    vim.keymap.set('n', 't<leader>f', function() require'jdtls'.test_class() end, { desc = "Test Java class" })
    vim.keymap.set('n', 't<leader>n', function() require'jdtls'.test_nearest_method() end, { desc = "Test nearest Java method" })
    end,
  }
}
