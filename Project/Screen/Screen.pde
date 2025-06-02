public abstract class Display{
  abstract void display();
  String currentScreen;
}

void setup(){
  //MainMenu m = new MainMenu();
  Play p = new Play();
  //m.display();
  p.display();
}
