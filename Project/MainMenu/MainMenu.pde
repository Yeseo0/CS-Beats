  import processing.sound.*;
  import java.util.ArrayList;
  
  private ArrayList<String> songList = new ArrayList<>();
  private ArrayList<Double> difficultyList = new ArrayList<>();
  private float volume = 0.5f; // default volume
  private int backgroundIndex = 0; // current previewing song
  private SoundFile[] songPreviews; // array of song preview files
  private String[] backgrounds; // array of song backgrounds
  
  public MainMenu(){
     songList.add("Clarity");
     songList.add("Beauty and a Beat");
     songList.add("Are You Bored Yet?");
    
    // number of stars to be earned upon completion
     difficultyList.add((double)1.0); // clarity --> easy
     difficultyList.add((double)2.0); // beauty and a beat --> medium
     difficultyList.add((double)3.0); // are you bored yet --> hard
     
     songPreviews = new SoundFile[3];
     songPreviews[0] = new SoundFile(this, "clarity_preview.mp3");
     songPreviews[1] = new SoundFile(this, "baab_preview.MP3");
     songPreviews[2] = new SoundFile(this, "ayby_preview.MP3");
     
     backgrounds = new String[3];
     backgrounds[0] = "clarityBackground.png";
     backgrounds[1] = "baabBackground.png";
     backgrounds[2] = "aybyBackground.png";
     
     currentScreen = "MainMenu";
  }
  
  private void playSong(){
    if (songPreviews[backgroundIndex] != null) {
          songPreviews[backgroundIndex].stop(); // stop previous preview if playing
          songPreviews[backgroundIndex].amp(0.3f); // set low volume
          songPreviews[backgroundIndex].play();
      }
  }
  
  public void changeBackground(){
    backgroundIndex = (backgroundIndex + 1) % songPreviews.length;
    playSong();
  }
  
  public void keyPressed(int key){
    if (key == LEFT) { 
        backgroundIndex = (backgroundIndex - 1 + backgrounds.length) % backgrounds.length; // moves left
        changeBackground();
    } else if (key == RIGHT) {
        backgroundIndex = (backgroundIndex + 1) % backgrounds.length; // moves right
        changeBackground();
    } else if (key == 'u') {
        volume = Math.min(volume + 0.1f, 1.0f); // increase volume
    } else if (key == 'd') {
        volume = Math.max(volume - 0.1f, 0.0f); // decrease volume
    }
  }
  
  public void setup(){
    size(1800,1000);
    loadImage(backgrounds[backgroundIndex]);
  }
  
  void mousePressed(){
    if (mouseX >= 800 && mouseX <= 1000 && mouseY >= 900 && mouseY <= 950){
      currScreen = "Play";
    }
    if (mouseX >= 900 && mouseX <= 950 && mouseY >= 50 && mouseY <= 100){
      currScreen = "HomePage";
    }
  }
