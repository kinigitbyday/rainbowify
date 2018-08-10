# rainbowify
Creates frames for a looping, colorful gif

Inspired by Bob Dylan's trippy gif (seriously, just search for those words and
you'll find it). Stuff like this: http://i.imgur.com/WosTYir.gif (beware, might
be too flashy).

**Warning:** If you're sensitive to flashing lights, some of the faster
animations might not be suited for you.

You'll need:

- Octave (`brew install octave`)
- The octave-image package 
- ImageMagick (`brew install imagemagick`)
- Gifsicle (`brew install gifsicle`)

Usage
------------------------------

### Easy
1. `./rainbowify.sh --base_image myimage.png [--output partyimage.gif]`
    - Rainbowified gifs go into a created `./rainbowify_out` directory
### Custom

1. Generate .png files by running 
    ```bash
    octave --silent --eval "rainbowify(\"base_image, out_folder, base_name, step\")"
    ```

    - `base_image`: the image to rainbowify. The script has been tested with a color
      JPG file but shouldn't encounter problems with other color formats.
      Grayscale images might produce errors, though.
    - `out_folder`: where you want the animation frames to be output. Keep in
      mind that up to 64 frames will be output. Therefore, an empty folder is
      recommended. If omitted, frames will be output to the current folder.
    - `base_name`: the prefix to give each frame image. If omitted, it defaults
      to "out". If you use a non-empty folder (not really recommended) try to
      use a base name that makes the frame images easily distinguishable from
      other files.
    - `step`: this determines how many frames will be output. A higher number
      results in fewer frames. Valid values are integers between 1 and 64. 
      Recommended values are 1 for slow animations, 4 for normal-speed animations
      and 8 for fast ones. Defaults to 4 if omitted.

2. Compile your frames into a gif!

    `cd`to the folder where you have the frames obtained from the previous step.

     ```bash
     convert -delay D ./base_name*.png -coalesce out_file.gif
     ```

     The `D` parameter determines gif speed (in particular, how many millisecond
     each frame gets), and can be combined with the previous `step` parameter to
     maintain a fluid animation that plays at the desired speed. A slow
     animation needs more frames; conversely, having too many frames imposes a
     limit on the animation's speed. I've used 1x40 (no quotes) for normal-speed
     animations and 1x20 for fast ones. For more information on this parameter,
     check the ImageMagick/`convert` documentation.

     Replace `base_name` with the base name you used in the previous step (or
     `out` if you omitted it). If you used an empty folder, as recommended,
     using `./*.png` works too.  Really, just bash stuff. 

     You can use another name for the output file, obviously.

     Try playing around with ImageMagick's many options. Really, I just messed
     around until I got something I liked.

     Enjoy!
