import java.util.Random;

color[] colors = {
  color(85, 239, 196),  color(129, 236, 236), color(116, 185, 255), color(162, 155, 254), color(223, 230, 233),
  color(0, 184, 148),   color(0, 206, 201),   color(9, 132, 227),   color(108, 92, 231),  color(178, 190, 195),
  color(255, 234, 167), color(250, 177, 160), color(255, 118, 117), color(253, 121, 168), color(99, 110, 114),
  color(253, 203, 110), color(225, 112, 85),  color(214, 48, 49),   color(232, 67, 147),  color(45, 52, 5)
};
// Parameters
int colorsOnScreen = 20;
int numColors = 20;
float speed = 0.05;
int octaves = 15;
float scl = 100;
boolean shuffle = false;

boolean recording = false;
float[][] grid;
float offset = 0;
float min = 1;
float max = 0;

void setup() {
  size(800, 800);
  noiseSeed(int(random(0, 100)));
  noiseDetail(octaves);
  if (shuffle) {
    shuffleArray(colors);
  }
  
  grid = new float[width][height];
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      grid[x][y] = (noise(x/scl, y/scl)-0.5) * 2;
    }
  }
  
  for (float[] row : grid) {
    min = min(min, min(row));
    max = max(max, max(row));
  }
}

void draw() {
  offset += speed;
  
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float val = map(grid[x][y], min, max, 0, colorsOnScreen);
      int colorIndex = int(val + offset) % (numColors);
      pixels[x + y*width] = colors[colorIndex];
    }
  }
  updatePixels();
  
  if (recording) {
    saveFrame("output/####.png");
  }
}

void keyPressed() {
  if (key == ' ') {
    setup();
  } else if (key == 'c') {
    shuffleArray(colors);
  } else if (key == 'r') {
    recording = !recording;
  }
}

void shuffleArray(int[] array) {
  Random rng = new Random();
  for (int i = array.length; i > 1; i--) {
    int j = rng.nextInt(i);
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}
