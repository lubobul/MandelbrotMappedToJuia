//Move the mouse across the mandelbrot's complex plane
//Observer how Julia set is changing on the right

// The only differece between Julia and Mandelbroth is that Julia set is confined by the complex number C 
// in the function z = z^2 + C as it is always constant throughout the iteration of the complex plane
// the Julia set is sometimes refferred to as Mandelbrot's dust, since locking down to a specific complex coordinate
// of the complex plane will determine the complex number C, therfore producing a slince in time of the whole Julia set

int windowWidth = 0;
int windowHeight = 0;

void setup() {
  
  size(1280, 480);
  windowWidth = width / 2;
  windowHeight = height;
  colorMode(HSB, 360, 100, 100);
  
  // Make sure we can write to the pixels[] array.
  loadPixels();
  
  //called only once because no transformations are used
  calcMandel();
}

void draw() {
  
  float ca = map(mouseX, 0, windowWidth, -1, 1);
  float cb = map(mouseY, 0, windowHeight, -1, 1);
  
  calcJulia(ca, cb);
  
  updatePixels();
  
  // follow the value of the complex number C
  println("C = " + ca + " + " + cb + "i");
} 


void calcMandel(){
  // Establish a range of values on the complex plane
  // A different range will allow us to "zoom" in or out on the fractal

  // It all starts with the windowWidth, try higher or lower values
  float w = 5;
  float h = (w * windowHeight) / windowWidth;
  // Start at negative half the windowWidth and windowHeight
  float xmin = -w/2;
  float ymin = -h/2;
  
  // Maximum number of iterations for each point on the complex plane, tweak this to change resolution
  int maxiterations = 50;

  // x goes from xmin to xmax
  float xmax = xmin + w;
  // y goes from ymin to ymax
  float ymax = ymin + h;

  // Calculate amount we increment x,y for each pixel
  float dx = (xmax - xmin) / (windowWidth);
  float dy = (ymax - ymin) / (windowHeight);

  // Start y
  float y = ymin;
  for (int j = 0; j < windowHeight; j++) {
    // Start x
    float x = xmin;
    for (int i = 0; i < windowWidth; i++) {

      // Now we test, as we iterate z = z^2 + cm does z tend towards infinity?
      float a = x;
      float b = y;
      int n = 0;
      
      while (n < maxiterations) {
        float aa = a * a;
        float bb = b * b;
        float twoab = 2.0 * a * b;
        a = aa - bb + x;
        b = twoab + y;
        // Infinty in our finite world is simple, let's just consider it 16
        if (a*a + b*b > 16) {
          break;  // Bail
        }
        n++;
      }

      // We color each pixel based on how long it takes to get to infinity
      // If we never got there, let's pick the color black
      if (n == maxiterations) {
        pixels[i+j*windowWidth*2] = color(0);
      } else {
        //You could come up with any colors here
        map(mouseX, 0, windowWidth, -1, 1);
        pixels[i+j*windowWidth*2] = color(map(n, 0, maxiterations, 0, 300),100,100);
      }
      x += dx;
    }
    y += dy;
  }
}

// accepts constant complex value for the complex number C (ca = x, cb = i)
void calcJulia(float ca, float cb){
  // Establish a range of values on the complex plane
  // A different range will allow us to "zoom" in or out on the fractal

  // It all starts with the windowWidth, try higher or lower values
  float w = 5;
  float h = (w * windowHeight) / windowWidth;

  // Start at negative half the windowWidth and windowHeight
  float xmin = -w/2;
  float ymin = -h/2;
  
  // Maximum number of iterations for each point on the complex plane
  int maxiterations = 50;

  // x goes from xmin to xmax
  float xmax = xmin + w;
  // y goes from ymin to ymax
  float ymax = ymin + h;

  // Calculate amount we increment x,y for each pixel
  float dx = (xmax - xmin) / (windowWidth);
  float dy = (ymax - ymin) / (windowHeight);

  // Start y
  float y = ymin;
  for (int j = 0; j < windowHeight; j++) {
    // Start x
    float x = xmin;
    for (int i = 0; i < windowWidth; i++) {

      // Now we test, as we iterate z = z^2 + cm does z tend towards infinity?
      float a = x;
      float b = y;
      int n = 0;
      while (n < maxiterations) {
        float aa = a * a;
        float bb = b * b;
        float twoab = 2.0 * a * b;
        a = aa - bb + ca;
        b = twoab + cb;
        // Infinty in our finite world is simple, let's just consider it 16
        if (a*a + b*b > 16) {
          break;  // Bail
        }
        n++;
      }

      // We color each pixel based on how long it takes to get to infinity
      // If we never got there, let's pick the color black
      if (n == maxiterations) {
        pixels[windowWidth+i+j*windowWidth*2] = color(0);
      } else {
        pixels[windowWidth + i+j*windowWidth*2] = color(map(n, 0, maxiterations, 0, 300),100,100);
      }
      x += dx;
    }
    y += dy;
  }
}