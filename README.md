# ColoredNoise
Colored Perlin Noise Animations

It generates a map of perlin noise at the beggining with `octaves` octaves, at `scl` scale, and quantizes the value for each pixel to `colorsOnScreen` different options. It uses that number to pick a color out of `colors` which is `numColors` long, and `shuffled` (color scheme from https://flatuicolors.com/palette/us). It then uses an offset, increasing by `speed` each frame to animate the colors.


Space - new noise

c - new colors

r - record
