 import processing.sound.*;
 import java.util.ArrayList;
 
 public class MainMenu{  
  private ArrayList<String> songList = new ArrayList<>();
  private ArrayList<Double> difficultyList = new ArrayList<>();
  private float volume = 0.5f; // default volume
  private int backgroundIndex = 0; // current previewing song
  private SoundFile[] songPreviews; // array of song preview files
  private PImage[] backgrounds = menuBackgrounds; // array of song backgrounds
  
  public MainMenu(PImage[] background, SoundFile[] previews){
    this.backgrounds = background;
    this.songPreviews = previews;
    bg = menuBackgrounds[backgroundIndex];
    currentScreen = "MainMenu";

    songList.add("Clarity");
    songList.add("Beauty and a Beat");
    songList.add("Are You Bored Yet?");
    
    // number of stars to be earned upon completion
     difficultyList.add((double)1.0); // clarity --> easy
     difficultyList.add((double)2.0); // beauty and a beat --> medium
     difficultyList.add((double)3.0); // are you bored yet --> hard
     
     songPreviews = new SoundFile[3];
     songPreviews[0] = clarity;
     songPreviews[1] = baab;
     songPreviews[2] = ayby;
  }
  
  void display(){
    background(0);
    image(bg, 0, 0);
  }
  
  private void playSong(){
    if (songPreviews[backgroundIndex] != null) {
          songPreviews[backgroundIndex].stop(); // stop previous preview if playing
          songPreviews[backgroundIndex].amp(0.3f); // set low volume
          songPreviews[backgroundIndex].play();
      }
  }
  
  void changeBackground(){
    backgroundIndex = (backgroundIndex + 1) % songPreviews.length;
    bg = backgrounds[backgroundIndex];
    playSong();

  }

 }
