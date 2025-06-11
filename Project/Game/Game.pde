// imports sound library
  import processing.sound.*;
  
  // images needed (backgrounds and arrows)
  PImage bg;
  PImage yellow, red, blue, green, arrowBar, quit;
  PImage home, main1, main2, main3, play;
  
  // fonts
  PFont font;
  
  // more global variables for backgrounds
  String currentScreen = "HomePage";
  PImage[] menuBackgrounds;
  int stars = 0;
  
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
    
    // font
    font = createFont("Georgia", 60);
    
    // arrows
    yellow = loadImage("arrows/yellowArrow.png");
    red = loadImage("arrows/redArrow.png");
    blue = loadImage("arrows/blueArrow.png");
    green = loadImage("arrows/greenArrow.png");
    arrowBar = loadImage("arrows/Arrows.png");
    quit = loadImage("arrows/Quit.png");

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
      if (y.played == false) {
        y.playSong();
        y.played = true;
      } else {
        y.display();
      }
    } else if (currentScreen.equals("Play")){
      if (z.played == false) {
        z.cooldownTime();
      } else {
        z.display();
      }
    }
  }
  
   void mousePressed(){
    if (currentScreen.equals("HomePage") && mouseX >= 510 && mouseX <= 1245 && mouseY >= 755 && mouseY <= 965){
      y = new MainMenu(menuBackgrounds, previews, stars);
      currentScreen = "MainMenu";
     }
   if (currentScreen.equals("MainMenu") && mouseX >= 470 && mouseX <= 800 && mouseY >= 775 && mouseY <= 925){
    y.getPreviewArray()[y.getLastBackgroundIndex()].stop();
    z = new Play(currentSong);
    bg = play;
    currentScreen = "Play";
    }
    if (currentScreen.equals("MainMenu") && mouseX >= 1600 && mouseX <= 1725 && mouseY >= 65 && mouseY <= 185){
      y.getPreviewArray()[y.getLastBackgroundIndex()].stop();
      x = new HomePage();
      bg = home;
      currentScreen = "HomePage";
    }
    if (currentScreen.equals("Play") && mouseX >= 1525 && mouseX <= 1795 && mouseY >= 5 && mouseY <= 140) {
      z.sample.cue(0);
      z.sample.pause();
      y = new MainMenu(menuBackgrounds, previews, stars);
      currentScreen = "MainMenu";
      y.resetBackground();
      currentSong = 0;
      sample1 = new SoundFile(this,songChoice[currentSong].getRoute());
    }
    if (currentScreen.equals("Play") && z.getResult()){
      stars += z.getStarsAdded();
      z.setStarsAdded(0);
      y = new MainMenu(menuBackgrounds, previews, stars);
      currentScreen = "MainMenu";
      y.resetBackground();
      currentSong = 0;
    }
  }

  
   void keyPressed(){
     
     // use setters as instance variables are private for class!!!
     
    if (keyCode == LEFT) { 
        if (y != null && currentScreen.equals("MainMenu")){
          y.changeBackgroundLeft();
          currentSong = (currentSong - 1 + songChoice.length) % songChoice.length;
          sample1 = new SoundFile(this, songChoice[currentSong].getRoute());
        }
    }
    if (keyCode == RIGHT) {
      if (y != null && currentScreen.equals("MainMenu")){ 
        y.changeBackgroundRight();
        currentSong = (currentSong + 1) % songChoice.length;
        sample1 = new SoundFile(this, songChoice[currentSong].getRoute());
      }
    }
    
    // volume kinda works (global)
    if (key == 'u') {
        Sound.volume(Math.min(y.getVolume() + 0.1, 1.0));
    }
    if (key == 'd') {
      println("run");
      Sound.volume(Math.max(y.getVolume() - 0.1, 0.0));
        
    }
    if (currentScreen.equals("Play") && key == CODED) {
      // need to edit so that all keypresseds are in the game sketch
      if (keyCode == LEFT) z.getArrows().left();
      else if (keyCode == RIGHT) z.getArrows().right();
      else if (keyCode == UP) z.getArrows().up();
      else if (keyCode == DOWN) z.getArrows().down();
    }
  }
