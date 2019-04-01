#!/bin/bash

if [ ! -d ./rainbowify_out ]; then
	mkdir rainbowify_out
fi

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        v="${1/--/}"
        declare $v="$2"
   fi

  shift
done

base_image_filename=$(basename -- "$base_image")
base_image_filename="${base_image_filename%.*}"

out=${output:-$base_image_filename.gif}
output_filename=$(basename -- "$out")
output_filename="${output_filename%.*}"
output="$output_filename.gif"

delay="1x10"

printf 'Argument base-image is "%s"\n' "$base_image"
printf 'Argument output is "%s"\n' "$out"

mkdir rainbowify_temp
if [[ $base_image == *.gif ]]; then
    delay=$(identify -verbose $base_image | grep -o "Delay: .*" | head -1 | cut -d " " -f2)
    octave --silent --eval "rainbowify_gif(\"$base_image\", \"rainbowify_temp\", \"temp\")"
else
    octave --silent --eval "rainbowify(\"$base_image\", \"rainbowify_temp\", \"temp\", 8)"
fi

cd rainbowify_temp
convert -dispose previous -delay $delay ./temp*.png -transparent black -coalesce ../rainbowify_out/$out
cd ../
rm -rf rainbowify_temp
cd rainbowify_out
gifsicle --resize-fit 128x128 $out -o $output_filename-slackmoji.gif
