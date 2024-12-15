# usage: rezip.sh src_dir

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 target_directory"
    exit 1
fi

target_dir="$1"
if [ ! -d "$target_dir" ]; then
    echo "Error: Directory $target_dir does not exist"
    exit 1
fi

mkdir -p output_zips

current_dir=$(pwd)

# テンプレートを設定
template="vol_%03d_v%03d.zip"

# 処理をする関数を定義
process_dir() {
    current_dir="$1"
    template="$2"
    dir="$3"
    base_dir=$(basename "$dir")
    num=$(echo "$base_dir" | grep -o '[0-9]\+' | head -1)
    
    # 数字が見つからない場合はスキップ
    if [ -z "$num" ]; then
        return
    fi
    
    version=1
    while [ -f "${current_dir}/output_zips/$(printf "$template" "$((10#$num))" "$version")" ]; do
        version=$((version + 1))
    done
    
    output_zip=$(printf "$template" "$((10#$num))" "$version")
    
    cd "$(dirname "$dir")"
    zip -r "${current_dir}/output_zips/${output_zip}" "$(basename "$dir")"
}
export -f process_dir
export current_dir
export template

# 指定されたディレクトリ配下のすべてのディレクトリを対象に
find "$target_dir" -type d -print0 | \
parallel -0 process_dir "$current_dir" "$template" {}
