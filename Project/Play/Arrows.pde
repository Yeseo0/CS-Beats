import java.util.ArrayList;

public class Arrows {
  private PImage yellow, red, blue, green, arrowBar;
  private PVector rate;
  private ArrayList<PVector> arrows = new ArrayList<>();;
  private ArrayList<Integer> modes = new ArrayList<>();;
  
  
  public Arrows(int fallRate, int mode) {
    rate = new PVector (0, fallRate);
    modes.add(mode);
  }
  
  void setup() {
    yellow = loadImage("ArrowImg/yellowArrow.png");
    red = loadImage("ArrowImg/redArrow.png");
    blue = loadImage("ArrowImg/blueArrow.png");
    green = loadImage("ArrowImg/greenArrow.png");
    arrowBar = loadImage("ArrowImg/Arrows.png");
  }
  
  void drawBar() {
    image(arrowBar, 300, 700);
  }
  
  void drawArrow(PVector arrow, int mode) {
    if (mode==0){
      image(red,arrow.x,arrow.y,185,185);
    }
    if (mode==1){
      image(yellow,arrow.x,arrow.y,185,185);
    }
    if (mode==2){
      image(blue,arrow.x,arrow.y,185,185);
    }
    if (mode==3){
      image(green,arrow.x,arrow.y,185,185);
    }
  }
  
  void addArrow(int mode){
    arrows.add(new PVector(200+mode*200, -50));
    modes.add(mode);
  }
  
  void update() {
    int i = 0;
    for (PVector arrow : arrows) {
      arrow = arrow.add(rate);
      int mode = modes.get(i);
      drawArrow(arrow, mode);
      i++;
    }
  }
  
  PVector getRate(){
    return rate;
  }
}
