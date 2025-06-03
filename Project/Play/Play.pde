import processing.sound.*;

double progress;
int stars;
double accuracy;
Song[] songChoice = {new Song("clarity", "Songs/clarity.mp3", "zedd", 3), new Song("are you bored yet?", "Songs/are you bored yet.mp3", "wallows", 2)};
int currentSong = 0;

SoundFile sample; // mp3 file
FFT fft; // fast fourier transform (changing input from time domain to frequency domain, detects beats)

float[] spectrum = new float[256]; // needs to be power of 2

float threshold = 2; // minimum energy to count as a beat
int cooldown = 300; // how long to wait between beats
int lastBeat = 0;

PImage yellow, red, blue, green;

Arrows arrow;

void setup() {
  size(1800, 1000);
  
  arrow = new Arrows((int) Math.pow(2, songChoice[currentSong].getDifficulty()), 0);
  arrow.setup();
  
  sample = new SoundFile(this, songChoice[currentSong].getRoute());
  sample.loop();
  
  fft = new FFT(this, 256);
  fft.input(sample);
}

// need to fix: 
// - arrows should fall down earlier than beat 
// - arrows of same color should fall down in same column
// - rotation thing 

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
