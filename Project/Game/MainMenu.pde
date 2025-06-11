import processing.sound.*;
 import java.util.ArrayList;
 
 public class MainMenu{  
  private ArrayList<String> songList = new ArrayList<>();
  private float volume = 0.5; // default volume
  private int backgroundIndex = 0; // current previewing song
  private int lastBackgroundIndex = 0;
  private SoundFile[] songPreviews; // array of song preview files
  private PImage[] backgrounds = menuBackgrounds; // array of song backgrounds
  private int stars;
  public boolean played = false;
  
  public MainMenu(PImage[] background, SoundFile[] previews, int stars){
    this.backgrounds = background;
    this.songPreviews = previews;
    bg = menuBackgrounds[backgroundIndex];
    currentScreen = "MainMenu";
    this.stars = stars;

    songList.add("Clarity");
    songList.add("Beauty and a Beat");
    songList.add("Are You Bored Yet?");
     
    songPreviews = new SoundFile[3];
    songPreviews[0] = clarity;
    songPreviews[1] = baab;
    songPreviews[2] = ayby;
  }
  
  void display(){
    background(0);
    image(bg, 0, 0);
    displayText();
  }
  
  void displayText(){
    fill(0, 200);
    rect(1050, 70, 450, 100, 50);
    textFont(font);
    textSize(100);
    fill(255);
    text("stars: " + stars, 1100, 150);    
  }
  
  public int getBackgroundIndex(){
    return backgroundIndex;
  }
  
  public void setBackgroundIndex(int index){
    backgroundIndex = index;
  }
  
  public SoundFile[] getPreviewArray(){
    return songPreviews;
  }
  
  public int getLastBackgroundIndex(){
    return lastBackgroundIndex;
  }
  
  public void setVolume(float v){
    volume = v;
  }

  public float getVolume(){
     return volume;
  }
  
  public PImage[] getBackgroundArray(){
    return backgrounds;
  }
  
  private void playSong(){
    if (songPreviews[backgroundIndex] != null) {
          songPreviews[backgroundIndex].amp(volume); // set low volume
          songPreviews[backgroundIndex].loop();
      }
  }
  
  void resetBackground() {
    backgroundIndex = 0;
    bg = backgrounds[backgroundIndex];
    playSong();
    lastBackgroundIndex = backgroundIndex;
  }
  
  void changeBackgroundLeft(){
    songPreviews[lastBackgroundIndex].stop();
    backgroundIndex = (backgroundIndex + 1) % songPreviews.length;
    bg = backgrounds[backgroundIndex];
    playSong();
    lastBackgroundIndex = backgroundIndex;
  }
  
  void changeBackgroundRight(){
    songPreviews[lastBackgroundIndex].stop();
    backgroundIndex = (backgroundIndex - 1 + songPreviews.length) % songPreviews.length;
    bg = backgrounds[backgroundIndex];
    playSong();
    lastBackgroundIndex = backgroundIndex;
  }

 }
