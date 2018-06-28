#!/bin/zsh

zmodload zsh/zutil
zparseopts -A ARGUMENTS -base-image: -output:

if [ ! -d ./rainbowify_out ]; then
	mkdir rainbowify_out
fi

base_image=$ARGUMENTS[--base-image]

base_image_filename=$(basename -- "$base_image")
base_image_filename="${base_image_filename%.*}"

output=${ARGUMENTS[--output]:-$base_image_filename.gif}
output_filename=$(basename -- "$output")
output_filename="${output_filename%.*}"
output="$output_filename.gif"

printf 'Argument base-image is "%s"\n' "$base_image"
printf 'Argument output is "%s"\n' "$output"

mkdir "rainbowify_temp"
octave --silent --eval "rainbowify(\"$base_image\", \"rainbowify_temp\", \"temp\", 8)"

cd "rainbowify_temp"
convert -delay 1x20 ./temp*.png -coalesce ../rainbowify_out/$output
cd ../
rm -rf "rainbowify_temp"
