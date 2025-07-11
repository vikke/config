#!/bin/env ruby

# 度分秒形式の緯度経度を10進数に変換する
def dms_to_decimal(dms_str)
  # 北緯/南緯、東経/西経を判定
  is_north = dms_str.include?('N')
  is_east = dms_str.include?('E')
  
  # 数値部分を抽出
  numeric_part = dms_str.gsub(/[NSEW]/, '').strip
  
  # 度、分、秒を抽出
  if numeric_part =~ /(\d+)°(\d+)'([\d.]+)"/
    degrees = $1.to_f
    minutes = $2.to_f
    seconds = $3.to_f
    
    # 10進数に変換
    decimal = degrees + (minutes / 60.0) + (seconds / 3600.0)
    
    # 南緯または西経の場合は負の値にする
    decimal = -decimal if (!is_north && !is_east)
    
    return decimal
  else
    raise "Invalid DMS format: #{dms_str}"
  end
end

# 緯度経度からタイル座標を計算する
def get_tile_coordinates(lat, lng, zoom)
  # 緯度を制限（-85.05112878～85.05112878）
  lat = [[lat, -85.05112878].max, 85.05112878].min
  
  # ラジアンに変換
  lat_rad = lat * Math::PI / 180
  
  # タイル座標を計算
  n = 2.0 ** zoom
  x = ((lng + 180.0) / 360.0 * n).to_i
  y = ((1.0 - Math.log(Math.tan(lat_rad) + 1.0 / Math.cos(lat_rad)) / Math::PI) / 2.0 * n).to_i
  
  return [x, y]
end

# メイン処理
if ARGV.empty?
  puts "使用法: ruby latlong.rb \"緯度 経度\" [ズームレベル]"
  puts "例: ruby latlong.rb \"35°46'00.8\\\"N 139°50'50.1\\\"E\" 15"
  exit 1
end

# コマンドライン引数から緯度経度を取得
latlong_str = ARGV[0]
zoom = (ARGV[1] || 15).to_i

# 緯度と経度を分離
if latlong_str =~ /([^,]+)\s+([^,]+)/
  lat_str = $1
  lng_str = $2
  
  begin
    # 度分秒から10進数に変換
    lat_decimal = dms_to_decimal(lat_str)
    lng_decimal = dms_to_decimal(lng_str)
    
    puts "10進数形式: #{lat_decimal}, #{lng_decimal}"
    
    # タイル座標を計算
    x, y = get_tile_coordinates(lat_decimal, lng_decimal, zoom)
    
    puts "ズームレベル: #{zoom}"
    puts "タイル座標: X=#{x}, Y=#{y}"
  rescue => e
    puts "エラー: #{e.message}"
    exit 1
  end
else
  puts "エラー: 緯度経度の形式が正しくありません"
  puts "例: 35°46'00.8\"N 139°50'50.1\"E"
  exit 1
end

