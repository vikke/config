export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

mkdir -p output_zips

current_dir=$(pwd)

# 処理をする関数を定義
process_dir() {
    current_dir="$1"
    dir="$2"
    base_dir=$(basename "$dir")
    num=$(echo "$base_dir" | grep -o '[0-9]\+' | head -1)
    padded_num=$(printf "%03d" "$((10#$num))")
    base_zip="土竜の唄 第${padded_num}巻.zip"
    
    output_zip="$base_zip"
    counter=2
    while [ -f "${current_dir}/output_zips/${output_zip}" ]; do
        output_zip="土竜の唄 第${padded_num}巻_v${counter}.zip"
        counter=$((counter + 1))
    done
    
    cd "$(dirname "$dir")"
    zip -r "${current_dir}/output_zips/${output_zip}" "$(basename "$dir")"
}
export -f process_dir
export current_dir

find . -type d \( -path "*/*" \) -print0 | \
parallel -0 process_dir "$current_dir" {}
