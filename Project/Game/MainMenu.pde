 import processing.sound.*;
 import java.util.ArrayList;
 
 public class MainMenu{  
  private ArrayList<String> songList = new ArrayList<>();
  private ArrayList<Double> difficultyList = new ArrayList<>();
  private float volume = 0.5f; // default volume
  private int backgroundIndex = 0; // current previewing song
  private SoundFile[] songPreviews; // array of song preview files
  private PImage[] backgrounds = new PImage[3]; // array of song backgrounds
  
  public MainMenu(PImage[] background, SoundFile[] previews){
    this.backgrounds = background;
    this.songPreviews = previews;
    bg = backgrounds[backgroundIndex];

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
  
  void keyPressed(int key){
    if (key == LEFT) { 
        backgroundIndex = (backgroundIndex - 1 + backgrounds.length) % backgrounds.length; // moves left
        currentSong = (currentSong-1) % songChoice.length;
        changeBackground();
    } else if (key == RIGHT) {
        backgroundIndex = (backgroundIndex + 1) % backgrounds.length; // moves right
        currentSong = (currentSong+1) % songChoice.length;
        changeBackground();
    } else if (key == 'u') {
        volume = Math.min(volume + 0.1f, 1.0f); // increase volume
    } else if (key == 'd') {
        volume = Math.max(volume - 0.1f, 0.0f); // decrease volume
    }
  }
    
  void mousePressed(){
    if (mouseX >= 800 && mouseX <= 1000 && mouseY >= 900 && mouseY <= 950){
      z = new Play();
      bg = play;
      currentScreen = "Play";
    }
    if (mouseX >= 900 && mouseX <= 950 && mouseY >= 50 && mouseY <= 100){
      x = new HomePage();
      bg = home;
      currentScreen = "HomePage";
    }
  }
 }
