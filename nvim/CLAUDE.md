# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリで作業する際のガイダンスを提供します。

## リポジトリ概要

このリポジトリはNeovimの設定で、Luaを主要な設定言語として使用し、lazy.nvimプラグインマネージャーを採用しています。プラグインは`lua/plugins/`配下に分割されたモジュール構造になっています。

## アーキテクチャと構造

### コアコンポーネント

1. **メイン設定**: `init.lua` - 基本設定、キーマップ、LSPアタッチ設定、nvim-cmpセットアップを含むエントリーポイント
2. **プラグイン管理**: lazy.nvimを使用し、`lua/plugins/`にモジュール化されたプラグイン定義
3. **プラグインロックファイル**: `lazy-lock.json` - 再現性のためのプラグインバージョン管理

### プラグインアーキテクチャ

各プラグインは`lua/plugins/`内に独自の設定ファイルを持つ:
- `lsp.lua` - Language Server Protocol設定 (ruby_lsp, ts_ls, lua_ls, bashls, pyright)
- `telescope.lua` - frecency拡張付きファジーファインダー
- `treesitter.lua` - シンタックスハイライトとインデント
- `neotree.lua` - ファイルエクスプローラー
- `theme.lua` - Icebergカラースキームと関数情報表示
- `autopairs.lua` - 括弧の自動ペアリング
- `sonicpi.lua` - Sonic Pi統合
- `vim-fugitive.lua` - Git統合
- `wakatime.lua` - 時間追跡
- `vimdoc-ja.lua` - 日本語ドキュメント

### 主要機能

- **WSLサポート**: win32yankを使用したWSL環境用の特別なクリップボード設定
- **LSP統合**: nvim-cmpによる自動補完を備えた複数の言語サーバー設定
- **診断表示**: lsp_linesによる拡張エラー表示
- **カスタムキーマップ**: リーダーキーを`,`に設定、telescopeとLSPの豊富なマッピング

## よく使うコマンド

### プラグイン管理
```bash
# Neovimを開くとlazy.nvimが自動でプラグインをインストール
nvim

# プラグインの更新（Neovim内で）
:Lazy update

# ロックファイルと同期
:Lazy restore
```

### キーマッピング (Leader = ,)
- `<C-N>` - Neotreeファイルエクスプローラーを開く
- `ff` - ファイル検索 (Telescope)
- `fg` - ライブgrep (Telescope)
- `fm` - Frecency（最近のファイル）
- `gd` - 定義へジャンプ (LSP)
- `K` - ホバードキュメント (LSP)
- `<space>rn` - シンボルのリネーム (LSP)
- `<space>f` - コードフォーマット (LSP)

### テスト/リント
自動テストやリントコマンドは設定されていません。LSPサーバーがリアルタイム診断を提供します。

## 開発メモ

- 設定はVim script レガシーファイル（ftplugin/, ftdetect/）とモダンなLuaの両方を使用
- ステータスラインはファイルエンコーディング、フォーマット、タイプ、カーソル位置、バイトコードを表示
- インデントメソッドでフォールディング有効、レベル3から開始
- Pythonホストはpyenvで設定: `~/.pyenv/shims/python`
- Sonic PiサーバーパスはWSL用に設定: `/mnt/c/Program Files/Sonic Pi/app/server`

## ディレクトリ構造
```
nvim/
├── init.lua           # メイン設定
├── lazy-lock.json     # プラグインバージョン
├── lua/
│   └── plugins/       # モジュール化されたプラグイン設定
├── ftplugin/          # ファイルタイプ固有の設定
├── ftdetect/          # ファイルタイプ検出
├── colors/            # カラースキーム
└── notuse/            # 非推奨のvjdeプラグイン（使用していない）
```