import processing.sound.*;

public class Play{
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
  
  public Play(){
    bg = play;
  }
  
  void display() {
    
    // cooldown and fall rate depends on difficulty and song itself 
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
    
    // delay in playing song
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
    text("score: " + arrow.getScore(), 40, 120);
    text("accuracy: " + (double) (arrow.getScore() / arrow.getTotalArrows()), 60, 140); 
    
    fft.analyze(spectrum);
  
    float beat = 0;
    for (int i = 0; i < 256; i++) { // calculates total energy so knows when spikes/energy occurs
      beat += spectrum[i];
    }
  
    int currentBeat = millis();
    
    // when the energy exceeds the threshold and occurs after the cooldown ends, queue an arrow
    if ((beat > threshold) && (millis() - lastBeat > cooldown)) {
      interval = currentBeat - lastBeat;
      lastBeat = currentBeat;
      nextBeat = currentBeat + interval;
      queued = true;
    }
      
     // generate a random arrow and unqueue arrow
     if (queued && currentBeat >= nextBeat - fall){
       int randomArrow = int(random(4));
       arrow.addArrow(randomArrow);
       arrow.incTotalArrows();
       queued = false;
     }
    
    // updates 
    arrow.update();
  }
  
  void mousePressed(){
    // what does this do??? exit the game or?
  }
  
  //void keyPressed() {
  //  if (key == CODED && arrow.getList().size() > 0) {
  //    if (keyCode == LEFT) {
  //      if (arrow.getList().get(0).getMode() == 0 && (arrow.getList().get(0).getPos().y > 830 && arrow.getList().get(0).getPos().y < 900)) {
  //        arrow.deleteArrow();
  //        arrow.incScore();
  //      }
  //    } else if (keyCode == RIGHT) {
  //      if (arrow.getList().get(0).getMode() == 2 && (arrow.getList().get(0).getPos().y > 830 && arrow.getList().get(0).getPos().y < 900)) {
  //        arrow.deleteArrow();
  //        arrow.incScore();
  //      }
  //    } else if (keyCode == UP) {
  //      if (arrow.getList().get(0).getMode() == 3 && (arrow.getList().get(0).getPos().y > 830 && arrow.getList().get(0).getPos().y < 900)) {
  //        arrow.deleteArrow();
  //        arrow.incScore();
  //      }
  //    } else if (keyCode == DOWN) {
  //      if (arrow.getList().get(0).getMode() == 1 && (arrow.getList().get(0).getPos().y > 830 && arrow.getList().get(0).getPos().y < 900)) {
  //        arrow.deleteArrow();
  //        arrow.incScore();
  //      }
  //    }
  //  }
  //}
}
