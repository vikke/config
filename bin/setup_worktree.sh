#!/bin/bash
# Serena の project_name を worktree のディレクトリ名に基づいて設定する
# 使い方: worktree のルートディレクトリで実行

set -e

if [ ! -f ".serena/project.yml" ]; then
    echo "Error: .serena/project.yml が見つかりません"
    exit 1
fi

# 現在のディレクトリ名とその親ディレクトリ名を取得
PROJECT_DIR=$(basename "$PWD")
WORKTREE_NAME=$(basename "$(dirname "$PWD")")

# project_name を更新
NEW_NAME="${PROJECT_DIR}-${WORKTREE_NAME}"
sed -i '' "s/^project_name:.*/project_name: \"${NEW_NAME}\"/" .serena/project.yml

echo "project_name を '${NEW_NAME}' に設定しました"
