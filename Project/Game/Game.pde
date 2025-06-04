  import processing.sound.*;
  
  public PImage bg;
  public PImage yellow, red, blue, green, arrowBar;
  public PImage home, main1, main2, main3, play;
  String currentScreen = "HomePage";
  HomePage x;
  MainMenu y;
  Play z;
  
  // main menu
  SoundFile clarity;
  SoundFile baab;
  SoundFile ayby;
  
  // play
  FFT fft1 = new FFT(this, 256);
  Song[] songChoice = {new Song("clarity", "songs/clarity.mp3", "zedd", 3), new Song("are you bored yet?", "songs/are you bored yet.mp3", "wallows", 1), new Song ("beauty and a beat", "songs/beauty and a beat.mp3", "justin bieber/nicki minaj", 2)};
  int currentSong = 0;
  SoundFile sample1 = new SoundFile(this, songChoice[currentSong].getRoute());
  
  void setup(){
     size(1900,1080);
     currentScreen = "HomePage";
     x = new HomePage();
     
     // song files
     clarity = new SoundFile(this, "previews/clarity_preview.mp3");
     baab = new SoundFile(this, "previews/baab_preview.mp3");
     ayby = new SoundFile(this, "previews/ayby_preview.mp3");
    
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
  
