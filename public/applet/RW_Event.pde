import processing.xml.*;
PImage bgImg;

ArrayList blocks;

FeedXml Fxml;
Nemo nemo;

void setup() {
  size(300, 300, P3D);
  smooth();

  Fxml = new FeedXml(this);
  Fxml.checkPrint();

  blocks = new ArrayList();
  for(int i = 0; i < Fxml.numCount; i++) {
    if(Fxml.getUrl[i] != null){
      blocks.add(new Nemo(Fxml.getUrl[i], random(width), random(height), 30, random(-0.25, 0.25) ) );
    }
  }
  
  bgImg = loadImage("bg.jpg");
  background(0);
}

void draw() {
  background(0);
  image(bgImg, 0, 0);
  int picNum = blocks.size() - (blocks.size()-15);
  
  for (int i = blocks.size()-1; i >= picNum; i--) {
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    Nemo nemo = (Nemo) blocks.get(i);
    nemo.move();
    nemo.display();
  }

}

void mousePressed() {
  // A new ball object is added to the ArrayList (by default to the end)
  blocks.add(new Nemo(Fxml.imgUrl(), mouseX, mouseY, 30, random(-0.25, 0.25) ) );
}
