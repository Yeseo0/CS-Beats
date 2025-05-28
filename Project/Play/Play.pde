<<<<<<< HEAD
import processing.sound.*;

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

boolean notePresent = false;
int textTime = 0;
int textDuration = 100; 

void setup() {
  size(500, 400);
  background(0);
  
  sample = new SoundFile(this, songChoice[currentSong].getRoute());
  sample.loop();
  
  fft = new FFT(this, 256);
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
    println("beat detected, energy: " + beat);
    lastBeat = millis(); // time of current beat

    // temp text to show note presence
    notePresent = true;
    textTime = millis(); // // time of text
    
    fill(0, 255, 0);
    ellipse(width / 2, height / 2, 100, 100);
  }

  if (notePresent && millis() - textTime < textDuration) { // if a note detected, have text that says it's detected until beat goes away
    fill(255, 255, 0);
    textSize(24);
    textAlign(CENTER);
    text("note detected", width / 2, 50);
  } else {
    notePresent = false;
=======
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
>>>>>>> Esther
  }
}
