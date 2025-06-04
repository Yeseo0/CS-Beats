public class HomePage{  
  HomePage(){
    bg = loadImage("homepage.png");
  }
  
  void display(){
    size(1800,1000);
    image(bg, 0, 0);
  }
  
  void mousePressed(){
   if (mouseX >= 700 && mouseX <= 1200 && mouseY >= 700 && mouseY <= 900){
      y = new MainMenu();
   }
  }
}
