import java.util.ArrayList;

class Arrows {
  private PImage yellow, red, blue, green;
  private PVector rate;
  private ArrayList<PVector> arrows = new ArrayList<>();;
  private ArrayList<Integer> modes = new ArrayList<>();;
  
  
  Arrows(int fallRate, int mode) {
    rate = new PVector (0, fallRate);
    arrows.add(new PVector (-10, -10));
    modes.add(mode);
  }
  
  void setup() {
    size(2100, 1250);
    yellow = loadImage("yellowArrow.gif");
    red = loadImage("redArrow.gif");
    blue = loadImage("blueArrow.gif");
    green = loadImage("blueArrow.gif");
  }
  void drawArrow(int mode) {
    
  }
  
  void draw() {
    rotate(PI/4.0);
    image(yellow, height/3.0, 325, 300, 300);
    int i = 0;
    for (PVector arrow : arrows) {
      arrow = arrow.add(rate);
      int mode = modes.get(i);
      drawArrow(i);
      i++;
    }
  }
}
