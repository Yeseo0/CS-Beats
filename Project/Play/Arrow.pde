import java.util.ArrayList;

public class Arrow {
  private PVector arrow;
  private int mode;
  private int name;
  
  public Arrow(PVector coord, int m, int num) {
    arrow = coord;
    mode = m;
    name = num;
  }
  
  public void setPos (PVector pos) {
    arrow = pos;
  }
  
  public PVector getPos () {
    return arrow;
  }
  
  public int getMode() {
    return mode;
  }
  
  public int getName() {
    return name;
  }
}
