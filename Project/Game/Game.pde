  // imports sound library
  import processing.sound.*;
  
  // images needed (backgrounds and arrows)
  PImage bg;
  PImage yellow, red, blue, green, arrowBar;
  PImage home, main1, main2, main3, play;
  
  // more global variables for backgrounds
  String currentScreen = "HomePage";
  PImage[] menuBackgrounds;
  
  // soundfile variables
  SoundFile[] previews;
  SoundFile clarity;
  SoundFile baab;
  SoundFile ayby;
  SoundFile sample1;
  
  // screens
  HomePage x;
  MainMenu y;
  Play z;
  
  // play (fft for beat detection)
  FFT fft1 = new FFT(this, 256);
  Song[] songChoice = {new Song("clarity", "songs/clarity.mp3", "zedd", 3), new Song("are you bored yet?", "songs/are you bored yet.mp3", "wallows", 1), new Song ("beauty and a beat", "songs/beauty and a beat.mp3", "justin bieber/nicki minaj", 2)};
  int currentSong = 0;
  
  void setup(){
     size(1778,1000);
     currentScreen = "HomePage";
     
     // LOADING FILES 
     
     // song files
     clarity = new SoundFile(this, "previews/clarity_preview.MP3");
     baab = new SoundFile(this, "previews/baab_preview.MP3");
     ayby = new SoundFile(this, "previews/ayby_preview.MP3");
     sample1 = new SoundFile(this, songChoice[currentSong].getRoute());
    
    // arrows
    yellow = loadImage("arrows/yellowArrow.png");
    red = loadImage("arrows/redArrow.png");
    blue = loadImage("arrows/blueArrow.png");
    green = loadImage("arrows/greenArrow.png");
    arrowBar = loadImage("arrows/Arrows.png");
    
    // backgrounds
    home = loadImage("backgrounds/homepage.png");
    play = loadImage("backgrounds/stage.png");
    main1 = loadImage("backgrounds/clarityBackground.png");
    main2 = loadImage("backgrounds/baabBackground.png");
    main3 = loadImage("backgrounds/aybyBackground.png");
    
    menuBackgrounds = new PImage[]{main1, main2, main3};
    previews = new SoundFile[]{clarity, baab, ayby};
    
    x = new HomePage();
    bg = home;
  }
  
// displays appropriate screen depending on the currentScreen variable 
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
  
