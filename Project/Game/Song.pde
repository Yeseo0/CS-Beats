import processing.sound.*;

public class Song{
  private String name;
  private String route; // file route
  private String singer;
  private int difficulty;
  
  public Song(String name, String route, String singer, int difficulty){
    this.name = name;
    this.route = route;
    this.singer = singer;
    this.difficulty = difficulty;
  }
  
  String getName(){
    return name;
  }
  
  String getRoute(){
    return route;
  }
  
  int getDifficulty(){
    return difficulty;
  } 
}
