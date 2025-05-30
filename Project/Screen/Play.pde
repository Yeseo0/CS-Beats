import processing.sound.*;
import java.util.ArrayList;

public class Play extends Display{
  
  double progress;
  int stars;
  double accuracy;
  Song[] songChoice = {new Song("clarity", "Songs/clarity.mp3", "zedd", 3), new Song("are you bored yet?", "Songs/are you bored yet.mp3", "wallows", 2)};
  int currentSong = 0;
  
  SoundFile sample;
  FFT fft;
  
  float[] spectrum = new float[256]; // needs to be power of 2
  
  float threshold = 2; // minimum energy to count as a beat
  int cooldown = 300; // how long to wait between beats
  int lastBeat = 0;
  
  PImage yellow, red, blue, green;
  
  Arrows arrow;
  
  public Play(){
   
  }

  public void display(){
    size(1800, 1000);
    arrow = new Arrows((int) Math.pow(2, songChoice[currentSong].getDifficulty()), 0);
    
    sample = new SoundFile(Screen.this, songChoice[currentSong].getRoute());
    sample.loop();
    
    fft = new FFT(Screen.this, 256);
    fft.input(sample);
  }
  
  void draw() {
    background(0);
    
    fft.analyze(spectrum);
  
    float beat = 0;
    for (int i = 0; i < 256; i++) { // calculates total energy so knows when spikes
      beat += spectrum[i];
    }
  
    if (beat > threshold && millis() - lastBeat > cooldown) {
      lastBeat = millis(); // time of current beat
  
      // arrows now fall with beat (need to implement delay)
      int randomArrow = int(random(4));
      arrow.addArrow(randomArrow);
    }
    
    arrow.update();
    
  }

  public class Arrows extends Play{
    private PImage yellow, red, blue, green;
    private PVector rate;
    private ArrayList<PVector> arrows = new ArrayList<>();;
    private ArrayList<Integer> modes = new ArrayList<>();;
    
    
    public Arrows(int fallRate, int mode) {
      yellow = loadImage("Arrows/yellowArrow.gif");
      red = loadImage("Arrows/redArrow.gif");
      blue = loadImage("Arrows/blueArrow.gif");
      green = loadImage("Arrows/greenArrow.gif");
      
      rate = new PVector (0, fallRate);
      modes.add(mode);
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
  
  public class Song extends Play{
    String name;
    String route; // file route
    String singer;
    int difficulty;
    
    public Song(String name, String route, String singer, int difficulty){
      this.name = name;
      this.route = route;
      this.singer = singer;
      this.difficulty = difficulty;
    }
    
    public String getName(){
      return name;
    }
    
    public String getRoute(){
      return route;
    }
    
    public int getDifficulty(){
      return difficulty;
    }
    
  }
  
}
