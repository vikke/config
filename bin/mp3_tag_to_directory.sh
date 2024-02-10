#!/bin/bash

# MP3 ファイルのパス
FILE=$1
BASE_DIR="/mnt/d/mp3s"

# eyeD3 を使用してメタデータを取得し、各変数に格納
ARTIST=$(eyeD3 "$FILE" | grep '^artist:' | sed 's/.*artist: \(.*\)/\1/' | sed 's#/#_#g')
TITLE=$(eyeD3 "$FILE" | grep '^title:' | sed 's/.*title: \(.*\)/\1/' | sed 's#/#_#g')
ALBUM=$(eyeD3 "$FILE" | grep '^album:' | sed 's/.*album: \(.*\)/\1/' | sed 's#/#_#g')
TRACK_NUM=$(eyeD3 "$FILE" | grep '^track:' | sed 's/.*track: \([[:digit:]]*\).*/\1/' | sed 's#/#_#g')

if [ "${ARTIST}" == "" -o "${TITLE}" == "" -o "${ALBUM}" == "" -o "${TRACK_NUM}" == "" ]; then
	cp "$1" "${BASE_DIR}"
fi

dest="${BASE_DIR}/${ARTIST}/${ALBUM}"
mkdir -p "${dest}"
cp "$1" "${dest}/${TRACK_NUM}_${TITLE}.mp3"
if [ $? -ne 0 ]; then
	echo "copy miss: $1"
fi
