import processing.sound.*;

public class Play{
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
  
  public Play(int currentSong) {
    bg = play;
    
    sample = sample1;
    fft = fft1;
    
    fft.input(sample);
    
    arrow = new Arrows((int) Math.pow(2, songChoice[currentSong].getDifficulty()));
    
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
    
  }
  
  void display() {
    background(bg);
    arrow.drawBar();
    
    // delay in playing song
    int now = millis();
    if (cooldown <= now){
      sample.playFor(sample.duration());
    }
    
    generateArrow();
   
  }
  
  void generateArrow() {
    
    textSize(100);
    text("score: " + arrow.getScore(), 40, 120);
    if (arrow.getTotalArrows() != 0){
      accuracy = (double) (arrow.getScore() / arrow.getTotalArrows());
      textSize(100);
      text("accuracy: " + accuracy, 40, 220); 
    }
    
    if (!sample.isPlaying()){
      if (accuracy < 0.25){
        stars++;
      } else if (accuracy < 0.5){
        stars+= 2; 
      } else if (accuracy < 0.65){
        stars += 3;
      } else if (accuracy < 0.79){
        stars += 4;
      } else {
        stars += 5;
      }
      
      y = new MainMenu(menuBackgrounds, previews, stars);
      bg = home;
      currentScreen = "MainMenu";
      return; 
    }
  

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
  
  Arrows getArrows(){
    return arrow;
  }

}
