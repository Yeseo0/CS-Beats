public class HomePage{  
  
  public HomePage(){
    bg = home;
  }
  
  void display(){
    image(bg, 0, 0);
  }
  
  void mousePressed(){
   if (mouseX >= 700 && mouseX <= 1200 && mouseY >= 700 && mouseY <= 900){
      y = new MainMenu(menuBackgrounds, previews);
      currentScreen = "MainMenu";
   }
  }
}
