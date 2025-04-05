#!/bin/bash

# 引数チェック
if [ $# -lt 2 ]; then
  echo "使用方法: $0 <commit-hash> <branch1> [branch2] ... または $0 <commit-hash> - (標準入力からブランチを読み込む)"
  exit 1
fi

COMMIT_HASH=$1
NOW_BRANCH=$(git branch --show-current)
STATE_DIR="/tmp/git-cherry-pick-state"
mkdir -p "$STATE_DIR"

# 状態ファイルのパス
STATE_FILE="$STATE_DIR/cherry-pick-state-$(echo $COMMIT_HASH | cut -c1-8).txt"
CURRENT_BRANCH_FILE="$STATE_DIR/cherry-pick-current-$(echo $COMMIT_HASH | cut -c1-8).txt"

# ブランチリストの取得
if [ "$2" = "-" ]; then
  # 標準入力からブランチを読み込む
  BRANCHES=()
  while IFS= read -r branch; do
    # 空行をスキップ
    if [ -n "$branch" ]; then
      BRANCHES+=("$branch")
    fi
  done
else
  # 引数からブランチを取得
  shift
  BRANCHES=("$@")
fi

# ブランチリストが空の場合はエラー
if [ ${#BRANCHES[@]} -eq 0 ]; then
  echo "エラー: ブランチが指定されていません"
  exit 1
fi

# 前回の実行状態をチェック
RESUME=false
START_INDEX=0

if [ -f "$STATE_FILE" ]; then
  COMPLETED_BRANCHES=$(cat "$STATE_FILE")
  
  # 現在処理中のブランチがある場合
  if [ -f "$CURRENT_BRANCH_FILE" ]; then
    CURRENT_BRANCH=$(cat "$CURRENT_BRANCH_FILE")
    echo "前回の実行は '$CURRENT_BRANCH' で中断されました。このブランチから再開します。"
    
    # 現在のブランチのインデックスを見つける
    for i in "${!BRANCHES[@]}"; do
      if [ "${BRANCHES[$i]}" = "$CURRENT_BRANCH" ]; then
        START_INDEX=$i
        RESUME=true
        break
      fi
    done
  else
    # 完了したブランチの数を数える
    COMPLETED_COUNT=$(echo "$COMPLETED_BRANCHES" | wc -l)
    
    if [ $COMPLETED_COUNT -gt 0 ]; then
      echo "前回の実行では $COMPLETED_COUNT 個のブランチが完了しました。"
      
      # 次のブランチから開始
      for i in "${!BRANCHES[@]}"; do
        BRANCH="${BRANCHES[$i]}"
        if ! echo "$COMPLETED_BRANCHES" | grep -q "^$BRANCH$"; then
          START_INDEX=$i
          RESUME=true
          break
        fi
      done
      
      if [ $RESUME = false ] && [ $COMPLETED_COUNT -eq ${#BRANCHES[@]} ]; then
        echo "すべてのブランチが既に処理されています。"
        exit 0
      fi
    fi
  fi
else
  # 新しい状態ファイルを作成
  touch "$STATE_FILE"
fi

echo "処理するブランチ: ${BRANCHES[@]:$START_INDEX}"
echo "コミットハッシュ: $COMMIT_HASH"
echo "現在のブランチ: $NOW_BRANCH"
echo "-----------------------------------"

# 各ブランチに対して処理を実行
for i in $(seq $START_INDEX $((${#BRANCHES[@]} - 1))); do
  BRANCH="${BRANCHES[$i]}"
  echo "=== ブランチ: $BRANCH ($((i+1))/${#BRANCHES[@]}) ==="
  
  # 現在処理中のブランチを記録
  echo "$BRANCH" > "$CURRENT_BRANCH_FILE"
  
  # ブランチをチェックアウト
  git checkout "$BRANCH"
  if [ $? -ne 0 ]; then
    echo "エラー: ブランチ '$BRANCH' のチェックアウトに失敗しました"
    exit 1
  fi
  
  # プル
  echo "git pull を実行中..."
  git pull 2> /tmp/pull_error.txt
  PULL_STATUS=$?
  
  # プルに失敗した場合、エラーメッセージを確認
  if [ $PULL_STATUS -ne 0 ]; then
    # トラッキング情報がない場合
    if grep -q "There is no tracking information for the current branch" /tmp/pull_error.txt; then
      echo "トラッキング情報がありません。upstreamを設定します..."
      git branch --set-upstream-to=origin/$BRANCH $BRANCH
      echo "再度 git pull を実行中..."
      git pull
      if [ $? -ne 0 ]; then
        echo "エラー: ブランチ '$BRANCH' での git pull に失敗しました"
        git checkout "$NOW_BRANCH"
        exit 1
      fi
    else
      echo "エラー: ブランチ '$BRANCH' での git pull に失敗しました"
      git checkout "$NOW_BRANCH"
      exit 1
    fi
  fi
  
  # cherry-pick
  echo "git cherry-pick $COMMIT_HASH を実行中..."
  git cherry-pick "$COMMIT_HASH"
  CHERRY_PICK_STATUS=$?
  
  # cherry-pickの結果を確認
  if [ $CHERRY_PICK_STATUS -ne 0 ]; then
    # 空のcherry-pickかどうかを確認
    CHERRY_PICK_OUTPUT=$(git status | grep -E "nothing to commit|cherry-pick.*empty")
    
    if [[ -n "$CHERRY_PICK_OUTPUT" && $(git status | grep -E "You are currently cherry-picking") ]]; then
      echo "空のcherry-pickが検出されました。コミットはすでに適用済みか変更が不要です。"
      echo "git cherry-pick --skip を実行します..."
      git cherry-pick --skip
      
      # 成功として扱う
      echo "ブランチ '$BRANCH' は既にこのコミットの変更を含んでいるか、変更が不要です。"
    else
      # 実際のコンフリクトまたはその他のエラー
      if git cherry-pick --abort 2>/dev/null; then
        echo "エラー: ブランチ '$BRANCH' での cherry-pick でコンフリクトが発生しました"
        echo "手動で解決してから再実行してください"
        exit 1
      else
        echo "エラー: ブランチ '$BRANCH' での cherry-pick に失敗しました"
        exit 1
      fi
    fi
  fi
  
  # プッシュ
  echo "git push を実行中..."
  git push
  if [ $? -ne 0 ]; then
    echo "エラー: ブランチ '$BRANCH' での git push に失敗しました"
    git checkout "$NOW_BRANCH"
  fi
  
  # 成功したブランチを記録
  echo "$BRANCH" >> "$STATE_FILE"
  
  # 現在処理中のブランチファイルを削除
  rm -f "$CURRENT_BRANCH_FILE"
  
  echo "ブランチ '$BRANCH' の処理が完了しました"
  echo ""
done

# 元のブランチに戻る
git checkout "$NOW_BRANCH"

# すべてのブランチが完了したら状態ファイルを削除
if [ $START_INDEX -eq 0 ] && [ $i -eq $((${#BRANCHES[@]} - 1)) ]; then
  rm -f "$STATE_FILE"
  echo "すべてのブランチの処理が完了しました。状態ファイルを削除しました。"
else
  echo "すべてのブランチの処理が完了しました。"
fi

exit 0
`
