import processing.sound.*;

public class Song extends Play{
  String name;
  String route; // file route
  String singer;
  int difficulty;
  
  public Song(String name, String route, String singer, int difficulty){
    this.name = name;
    this.route = route;
    this.singer = singer;
    this.difficulty = difficulty;
  }
  
  public String getName(){
    return name;
  }
  
  public String getRoute(){
    return route;
  }
  
  public int getDifficulty(){
    return difficulty;
  }
}
