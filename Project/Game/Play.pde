import processing.sound.*;

public class Play{
  double accuracy;
  double percent;
  
  SoundFile sample;
  FFT fft;
  
  float[] spectrum = new float[256]; // needs to be power of 2
  
  float threshold = 2; // minimum energy to count as a beat
  int cooldown; // how long to wait between beats
  int lastBeat = 0;
  
  int fall;
  int nextBeat = 0;
  int interval = 100;
  int starsAdded;
  
  boolean queued = false;
  boolean showResults = false; 
  
  Arrows arrow;
  
  PImage bg;
  
  public boolean played = false;
  
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
      cooldown = 850;
      fall = 3000;
    } else if (currentSong == 2) {
      cooldown = 750;
      fall = 2940;
    }
  }
  
  void cooldownTime() {
    // delay in playing song
    int now = millis();
    if (cooldown <= now){
      sample.playFor(sample.duration());
    }
    played = true;
  }
  
  // displays everything
  void display() {
    background(bg);
    arrow.drawBar();
    
    if (showResults){
      results();
    } else {
      generateArrow();
    }
  }
  
  void generateArrow() {
    
    displayScore();

    // if the song ends, go to results screen
    if (!sample.isPlaying() && !showResults){
      accuracy = (double) arrow.getScore() / arrow.getTotalArrows();
      percent = accuracy*100;
      
      if (percent < 25){
        starsAdded = 1;
      } else if (percent < 50){
        starsAdded = 2; 
      } else if (percent < 65){
        starsAdded = 3;
      } else if (percent < 79){
        starsAdded = 4;
      } else {
        starsAdded = 5;
      }
      
      if (songChoice[currentSong].getDifficulty() == 2){
        starsAdded *= 2;
      } else if (songChoice[currentSong].getDifficulty() == 3){
        starsAdded *= 3;
      }
      
      showResults = true;
      return; 
    }

    // otherwise, analyze using fft
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
       queued = false;
     }
    
    // updates 
    arrow.update();
  }
  
  void displayScore(){
    resetMatrix();
    fill(0, 200);
    rect(50, 45, 500, 105, 50);
    textFont(font);
    textSize(100);
    fill(255);
    text("Score: " + arrow.getScore(), 100, 120);
    percent = 0;
    resetMatrix();
  }
  
  // creates result screen
  void results(){
    resetMatrix();
    fill(#000080, 200); 
    rect(300, 250, 1280, 400, 20);
    
    fill(255);
    textSize(60);
    textFont(font);
    textAlign(CENTER, CENTER);
    text("Accuracy: " + (int) percent + "%", 950, 340);
    text("Stars Earned: " + starsAdded, 950, 420);
    text("Total Stars: " + (stars + starsAdded), 950, 500);
  
    text("Click anywhere to return to song selection!", 925, 580);
    
    resetMatrix();
  }
  
  Arrows getArrows(){
    return arrow;
  }
  
  boolean getResult(){
    return showResults;
  }
  
  void setStarsAdded(int s){
    starsAdded = s;
  }
  
  int getStarsAdded(){
    return starsAdded;
  }
  
}
