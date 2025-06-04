import processing.sound.*;
public class Play{
  double progress;
  int stars;
  double accuracy;
  
  SoundFile sample;
  FFT fft;
  
  float[] spectrum = new float[256]; // needs to be power of 2
  
  float threshold = 2; // minimum energy to count as a beat
  int cooldown; // how long to wait between beats
  int lastBeat = 0;
  
  int fall;
  int nextBeat = 0;
  int interval = 100;
  
  boolean queued = false;
  
  Arrows arrow;
  
  PImage bg;
  
  void display() {
    size(1920, 1080);
    
    bg = loadImage("stage.png");
    
    if (currentSong == 0) {
      cooldown = 500;
      fall = 2730;
    } else if (currentSong == 1) {
      cooldown = 1000;
      fall = 11090;
    } else if (currentSong == 3) {
      cooldown = 500;
      fall = 0;
    }
    
    arrow = new Arrows((int) Math.pow(2, songChoice[currentSong].getDifficulty()));
    
    sample = sample1;
    
    int now = millis();
    if (cooldown <= now){
      sample.play();
    }
    
    fft = fft1;
    fft.input(sample);
    
    generateArrow();
   
  }
  
  void generateArrow() {
    background(bg);
    arrow.drawBar();
    
    fft.analyze(spectrum);
  
    float beat = 0;
    for (int i = 0; i < 256; i++) { // calculates total energy so knows when spikes
      beat += spectrum[i];
    }
  
    int currentBeat = millis();
    
    if ((beat > threshold) && (millis() - lastBeat > cooldown)) {
      interval = currentBeat - lastBeat;
      lastBeat = currentBeat;
      nextBeat = currentBeat + interval;
      queued = true;
    }
      
     if (queued && currentBeat >= nextBeat - fall){
       int randomArrow = int(random(4));
       arrow.addArrow(randomArrow);
       queued = false;
     }
      
    arrow.update();
  }
  
  void mousePressed(){
  }
  
  /*void keyPressed() {
    if (key == CODED && Arrows.size() > 0) {
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
  */
}
