# プロジェクト概要
- 目的: 個人用 Neovim 設定 (Lua) で各種プラグインやキーマップを管理。
- 技術スタック: Neovim 0.8+ 想定、Lua、Lazy.nvim をプラグインマネージャとして使用。
- エントリ: init.lua が全設定の起点で、`lua/plugins` から Lazy.nvim の spec を読み込む。
- 主な利用プラグイン: nvim-cmp(+vsnip, nvim-autopairs), telescope, LSP 設定、sonicpi、neotree など (lazy-lock.json に固定バージョンが記録)。
- 文字コード: UTF-8 (ambiguous width double)。