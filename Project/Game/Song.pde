import processing.sound.*;

public class Song{

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
