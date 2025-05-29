import java.util.ArrayList;

public class Arrows {
  private PImage yellow, red, blue, green;
  private PVector rate;
  private ArrayList<PVector> arrows = new ArrayList<>();;
  private ArrayList<Integer> modes = new ArrayList<>();;
  
  
  public Arrows(int fallRate, int mode) {
    rate = new PVector (0, fallRate);
    modes.add(mode);
  }
  
  void setup() {
    yellow = loadImage("yellowArrow.gif");
    red = loadImage("redArrow.gif");
    blue = loadImage("blueArrow.gif");
    green = loadImage("greenArrow.gif");
  }
  
  void drawArrow(PVector arrow, int mode) {
    if (mode==0){
      image(red,arrow.x,arrow.y,200,200);
    }
    if (mode==1){
      image(yellow,arrow.x,arrow.y,200,200);
    }
    if (mode==2){
      image(blue,arrow.x,arrow.y,200,200);
    }
    if (mode==3){
      image(green,arrow.x,arrow.y,200,200);
    }
  }
  
  void addArrow(int mode){
    arrows.add(new PVector(200+mode*200, -50));
    modes.add(mode);
  }
  
  void update() {
    //rotate(PI/4.0);
    //image(yellow, height/3.0, 325, 300, 300);
    
    //rotate(PI/4.0);
    //image(red, height/3.0, 325, 600, 300);
    
    //rotate(PI/4.0);
    //image(blue, height/3.0, 325, 900, 300);
    
    //rotate(PI/4.0);
    //image (green, height/3.0, 325, 1200, 300);
    rect(200, 700, 1500, 200);
    int i = 0;
    for (PVector arrow : arrows) {
      arrow = arrow.add(rate);
      int mode = modes.get(i);
      drawArrow(arrow, mode);
      i++;
    }
  }
}
