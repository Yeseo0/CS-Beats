import java.util.ArrayList;

public class Arrows {
  private PImage yellow, red, blue, green, arrowBar;
  private PVector rate;
  private ArrayList<Arrow> arrows = new ArrayList<>();
  private ArrayList<Arrow> pastA = new ArrayList<>();
  private ArrayList<Integer> arrowNames = new ArrayList<>();
  private ArrayList<Integer> pastNames = new ArrayList<>();
  private int score = 0;
  private int counter = 0;
  
  
  public Arrows(int fallRate) {
    rate = new PVector (0, fallRate);
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
    Arrow count = new Arrow (new PVector (0, -50), mode, counter);
    arrowNames.add(counter);
    counter++;
    arrows.add(count);
  }
  
  public void deleteArrow() {
    arrows.remove(0);
    arrowNames.remove(0);
  }
  
  
  void moveArrow(Arrow arr) {
    if (arrowNames.contains(arr.getName()) == true && pastNames.contains(arr.getName()) == false) {
      Arrow store = arrows.remove(0);
      int name = arrowNames.remove(0);
      pastA.add(store);
      pastNames.add(name);
      arr.setPos(arr.getPos().add(rate));
      drawArrow(arr.getPos(), arr.getMode());
    }
  }
  
  void update() {
    for (int i = arrows.size() - 1; i >= 0; i--) {
      Arrow arr = arrows.get(i);
      if (arr.getPos().y > 900) {
        moveArrow(arr);
      } else {
        if (i < pastA.size()) {
          int index = pastA.size() - 1 - i;
          if (index < 0) {
            index = 0;
          }
          Arrow arrow = pastA.get(index);
          arrow.setPos(arrow.getPos().add(rate));
          drawArrow(arrow.getPos(), arrow.getMode());
        }
        arr.getPos().add(rate);
        drawArrow(arr.getPos(), arr.getMode());
      }
    }
  }
  
  void keyPressed() {
    if (key == CODED && arrows.size() > 0) {
      if (keyCode == LEFT) {
        if (arrows.get(0).getMode() == 0 && (arrows.get(0).getPos().y > 830 && arrows.get(0).getPos().y < 900)) {
          deleteArrow();
          score++;
        }
      } else if (keyCode == RIGHT) {
        if (arrows.get(0).getMode() == 2 && (arrows.get(0).getPos().y > 830 && arrows.get(0).getPos().y < 900)) {
          deleteArrow();
          score++;
        }
      } else if (keyCode == UP) {
        if (arrows.get(0).getMode() == 3 && (arrows.get(0).getPos().y > 830 && arrows.get(0).getPos().y < 900)) {
          deleteArrow();
          score++;
        }
      } else if (keyCode == DOWN) {
        if (arrows.get(0).getMode() == 1 && (arrows.get(0).getPos().y > 830 && arrows.get(0).getPos().y < 900)) {
          deleteArrow();
          score++;
        }
      }
    }
  }
  
  public PVector getRate(){
    return rate;
  }
  
  public int getScore() {
    return score;
  }
  
  public ArrayList<Arrow> getList() {
    return arrows;
  }
  
}
