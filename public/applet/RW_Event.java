import processing.core.*; 
import processing.xml.*; 

import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class RW_Event extends PApplet {


PImage bgImg;

ArrayList blocks;

FeedXml Fxml;
Nemo nemo;

public void setup() {
  size(300, 300, P3D);
  smooth();

  Fxml = new FeedXml(this);
  Fxml.checkPrint();

  blocks = new ArrayList();
  for(int i = 0; i < Fxml.numCount; i++) {
    if(Fxml.getUrl[i] != null){
      blocks.add(new Nemo(Fxml.getUrl[i], random(width), random(height), 30, random(-0.25f, 0.25f) ) );
    }
  }
  
  bgImg = loadImage("bg.jpg");
  background(0);
}

public void draw() {
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

public void mousePressed() {
  // A new ball object is added to the ArrayList (by default to the end)
  blocks.add(new Nemo(Fxml.imgUrl(), mouseX, mouseY, 30, random(-0.25f, 0.25f) ) );
}

class FeedXml {
  final String feedUrl = "http://xmastree.randomwalks.org/tweets.xml";

  String[] getUrl;
  String[] getScreenName;

  XMLElement xml;

  int numCount;

  FeedXml(PApplet app) {
    xml = new XMLElement(app, feedUrl);
    numCount = xml.getChildCount();

    getUrl        = new String[numCount];
    getScreenName = new String[numCount];
  }

  public String imgUrl() {
    String string = null;
    XMLElement[] picName = xml.getChildren("tweet/pic");
    for (int i = 0; i < picName.length; i++) {
      String url = picName[i].getContent();
      if(url != null){
        string = url;
      }
    }
    return string;
  }

  public String name() {
    String string = null;
    XMLElement[] screenName = xml.getChildren("tweet/screen_name");
    for (int i = 0; i < screenName.length; i++) {
      String url = screenName[i].getContent();
      if(url != null){
        string = url;
      }
    }
    return string;
  }
  
  public void getContents(){
    XMLElement[] screenName = xml.getChildren("tweet/screen_name");
    XMLElement[] picName = xml.getChildren("tweet/pic");
    for (int i = 0; i < screenName.length; i++) {
      String urlS = screenName[i].getContent();
      String urlP = picName[i].getContent();
      
      if(screenName != null){
        getScreenName[i] = urlS;     
      }
      if(picName != null){
        getUrl[i]        = urlP;
      }
    }
  }
    

  public void checkPrint() {
    getContents();
//    println(getUrl);
//    println(getScreenName);
  }
}

class Nemo {
  
  float x;
  float y;
  float speed;
  float gravity;
  float w;
  float life = 255;
  
  float angle;
  float diameter;
  
  String url;
  
  PImage img;
  PImage hat;
  
  Nemo(String url, float tempX, float tempY, float tempW, float tempD) {
    x = tempX;
    y = tempY;
    w = tempW;
    speed = 0;
    gravity = 0.1f;
    diameter = tempD;
    
    this.url = url;
    img = loadImage(url);
    hat = loadImage("hat.png");
  }
  
    public void move() {
    // Add gravity to speed
    speed = speed + gravity;
    // Add speed to y location
    y = y + speed;
    // If square reaches the bottom
    // Reverse speed
    if (y > height) {
      // Dampening
      speed = speed * -0.8f;
      y = height;
    }
    
    diameter = sin(angle) / 4;
    angle += 0.02f;
    if (angle > TWO_PI) { angle = 0; }
  }
  
  public boolean finished() {
    // Balls fade out
    life--;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  public void display() {
    // Display the circle
    pushMatrix();
    translate(x, y -w);
      beginShape();
      texture(img);
      noStroke();
      vertex(0, 0, 0, 0);
      vertex(w, 0, img.width, 0);
      vertex(w, w, img.width, img.height);
      vertex(0, w, 0, img.height);
      endShape();
      pushMatrix();
      {
        translate(w/2, 0);
        rect(0, 0, 5, 5);
        rotate(diameter);
        image(hat, -w/2 -3, -36, w+15, w+15);
      }
      popMatrix();
    popMatrix();
  }
  
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#C0C0C0", "RW_Event" });
  }
}
