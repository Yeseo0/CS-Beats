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

int fall;
int nextBeat = 0;
int interval = 100;

boolean queued = false;

Arrows arrow;

PImage bg;

void setup() {
  size(1920, 1080);
  
  bg = loadImage("Stage.png");
  
  arrow = new Arrows((int) Math.pow(2, songChoice[currentSong].getDifficulty()), 0);
  arrow.setup();
  
  fall = int(700/arrow.getRate().mag());
  
  sample = new SoundFile(this, songChoice[currentSong].getRoute());
  sample.loop();
  
  fft = new FFT(this, 256);
  fft.input(sample);
}

void draw() {
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
  arrow.setup();
}
