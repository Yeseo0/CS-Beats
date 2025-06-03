import java.util.ArrayList;

public class Arrows {
  private PImage yellow, red, blue, green, arrowBar;
  private PVector rate;
  private ArrayList<PVector> arrows = new ArrayList<>();;
  private ArrayList<Integer> modes = new ArrayList<>();;
  private int score = 0;
  
  
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
    image(arrowBar, 350, 850);
  }
  
  void drawArrow(PVector arrow, int mode) {
    if (mode==0){
      image(red,775,arrow.y,162,162);
    }
    if (mode==1){
      image(yellow,502,arrow.y,170,170);
    }
    if (mode==2){
      image(blue,1007,arrow.y,167,167);
    }
    if (mode==3){
      image(green,1280,arrow.y,165,165);
    }
  }
  
  void addArrow(int mode){
    arrows.add(new PVector(200+mode*200, -50));
    modes.add(mode);
  }
  
  void deleteArrow() {
    arrows.remove(0);
    modes.remove(0);
  }
  
  void update() {
    for (int i = arrows.size() - 1; i >= 0; i--){
      PVector arrow = arrows.get(i);
      int mode = modes.get(i);
      arrow.add(rate);
      drawArrow(arrow, mode);
      
      if (arrow.y > height){
        deleteArrow();
      }
    }
    keyPressed();
  }
  
  void keyPressed() {
    if (key == CODED) {
      if (keyCode == LEFT) {
        if (modes.get(0) == 0 && (arrows.get(0).y > 830 && arrows.get(0).y < 900)) {
          deleteArrow();
          score++;
        }
      } else if (keyCode == RIGHT) {
        if (modes.get(0) == 2 && (arrows.get(0).y > 830 && arrows.get(0).y < 900)) {
          deleteArrow();
          score++;
        }
      } else if (keyCode == UP) {
        if (modes.get(0) == 3 && (arrows.get(0).y > 830 && arrows.get(0).y < 900)) {
          deleteArrow();
          score++;
        }
      } else if (keyCode == DOWN) {
        if (modes.get(0) == 1 && (arrows.get(0).y > 830 && arrows.get(0).y < 900)) {
          deleteArrow();
          score++;
        }
      }
    }
  }
  
  PVector getRate(){
    return rate;
  }
  
  int getScore() {
    return score;
  }
}
