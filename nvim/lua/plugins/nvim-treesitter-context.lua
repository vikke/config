return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = "BufReadPost",
  config = function()
    require('treesitter-context').setup({
      enable = true,
      max_lines = 3, -- 表示する最大行数（関数名が長い場合の制限）
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = 'outer',
      mode = 'cursor', -- カーソル位置を基準にコンテキストを計算
      separator = '-', -- コンテキストとコンテンツの区切り文字
      include_surrounding_whitespace = true, -- 関数周辺の空白行やコメントを含める
      zindex = 20,
      on_attach = function(bufnr)
        -- 特定のファイルタイプで無効化したい場合
        local filetype = vim.bo[bufnr].filetype
        if filetype == "markdown" or filetype == "txt" then
          return false
        end
        return true
      end,
    })

    -- コンテキストへジャンプするキーマップ
    vim.keymap.set("n", "[c", function()
      require("treesitter-context").go_to_context(vim.v.count1)
    end, { silent = true, desc = "Jump to context" })

    -- トグルコマンドのキーマップ
    vim.keymap.set("n", "<leader>tc", "<cmd>TSContextToggle<CR>", { desc = "Toggle treesitter context" })
  end
}
