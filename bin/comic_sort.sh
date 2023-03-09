IFS=$'\n'
idx=1
for f in $(ls * | grep -E '\.(jpg|JPG|png|PNG)'| sort -V); do
	lower_case=${f,,}
	mv "${f}" $(printf '%0.3d' ${idx}).${f##*.}
	idx=$(expr $idx + 1)
done
