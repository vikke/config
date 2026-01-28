# スタイル/規約
- Lua で設定を書く。プラグイン設定は `lua/plugins` 以下に分割。
- フォーマット/インデント: `tabstop=4`, `shiftwidth=4`, `expandtab` は設定されておらずデフォルト (tab) 前提。折り畳み indent/level=3, 開始 99。
- キーマップ: `<space>` 系は LSP、`<C-N>` で Neotree、リーダーは `,`。
- 配色: `colorscheme iceberg`。
- LSP attach 時に基本操作を buffer-local に設定 (gd/gD/K など)。
- CMP: `vsnip` で展開、sources は `sonicpi`, `nvim_lsp` を主に使用。ghost_text 有効。
- 一般オプション: clipboard=unnamedplus, autoread, list 表示、背景 dark、encoding/fileencoding は utf-8。
- 文字幅: `ambiwidth=double`。