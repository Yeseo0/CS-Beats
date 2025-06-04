  import processing.sound.*;
  PImage bg;
  String currentScreen = "HomePage";
  HomePage x;
  MainMenu y;
  Play z;
  
  SoundFile clarity = new SoundFile(this, "clarity_preview.mp3");
  SoundFile baab = new SoundFile(this, "baab_preview.MP3");
  SoundFile ayby = new SoundFile(this, "ayby_preview.MP3");
  
  FFT fft1 = new FFT(this, 256);
  Song[] songChoice = {new Song("clarity", "Songs/clarity.mp3", "zedd", 3), new Song("are you bored yet?", "Songs/are you bored yet.mp3", "wallows", 1), new Song ("beauty and a beat", "Songs/beauty and a beat.mp3", "justin bieber/nicki minah", 2)};
  int currentSong = 0;
  SoundFile sample1 = new SoundFile(this, songChoice[currentSong].getRoute());
  
  void setup(){
     size(1800,1000);
     currentScreen = "HomePage";
     x = new HomePage();
  }
  
  void draw(){
    if (currentScreen.equals("HomePage")){
      x.display();
    } else if (currentScreen.equals("MainMenu")){
      y.display();
    } else{
      z.display();
    }
  }
  
  void mousePressed(){
    if (currentScreen.equals("HomePage")){
      x.mousePressed();
    } else if (currentScreen.equals("MainMenu")){
      y.mousePressed();
    } else{
      z.mousePressed();
    }
  }
  
