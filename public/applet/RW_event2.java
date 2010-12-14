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

public class RW_event2 extends PApplet {



//import processing.opengl.*;
//import javax.media.opengl.*;

PImage bgImg;

FeedXml Fxml;

Flock flock;

//camera
public float cam_A = 0;
public float cam_Y = 300;
public float cam_Z = 500;
float p_cam_A, p_cam_Y, p_cam_Z;

int pre_url;
public void setup() {
  size(300, 300, P3D);
  flock = new Flock();

  Fxml = new FeedXml(this);
  Fxml.checkPrint();

  // Add an initial set of boids into the system
  for(int i = 0; i < Fxml.endNum; i++) {
    //    println(Fxml.getUrl[i]);
    flock.addBoid(new Boid(
    new PVector(
    random(width), height/2), 3.0f, 0.05f, Fxml.getUrl[i]) );
  }

  bgImg = loadImage("bg.jpg");
  background(252, 115, 202);
}

public void draw() {
  background(252, 115, 202);
  image(bgImg, -150, -150, 600, 600);

  //  ortho(0, width, 0, height, -1000, 1000);
  ortho(-width * 0.5f, width * 0.5f, -height * 0.5f, height * 0.5f, -1000, 1000);
  camera(500.0f, 0.0f, 300.0f,
  width/2, height/2, 0,
  0, 0, -1);

  flock.run();
  picUpdate();
}


public void picUpdate() {
  float m = (millis() * 0.05f) % 1500;
//  println(int(m) +" "+second());

  if( PApplet.parseInt(m) == 0) {
//    println("update");
    Fxml = new FeedXml(this);

    if(Fxml.numCount != pre_url) {
      //      println("on");
      flock.addBoid(new Boid(new PVector(10, 10), 2.0f, 0.05f, Fxml.imgUrl() ));
    }
    pre_url = Fxml.numCount;
  }
}

// The Boid class

class Boid {

  PVector loc;
  PVector vel;
  PVector acc;
  float z;
  
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  
  int w = 30;

  PImage img;
  PImage hat;
  
  float angle;
  float diameter;
  
  Boid(PVector l, float ms, float mf, String url) {
    acc = new PVector(0,0);
    vel = new PVector(random(-1,1),random(-1,1));
    loc = l.get();
    r = 30.0f;
    maxspeed = ms;
    maxforce = mf;
    

    img = loadImage(url);
    hat = loadImage("hat.png");
  }

  public void run(ArrayList boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  // We accumulate a new acceleration each time based on three rules
  public void flock(ArrayList boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5f);
    ali.mult(1.0f);
    coh.mult(1.0f);
    // Add the force vectors to acceleration
    acc.add(sep);
    acc.add(ali);
    acc.add(coh);
  }

  // Method to update location
  public void update() {
    // Update velocity
    vel.add(acc);
    // Limit speed
    vel.limit(maxspeed);
    loc.add(vel);
    // Reset accelertion to 0 each cycle
    acc.mult(0);
    
    z = abs(sin(angle) );
    diameter = sin(angle) / 4;
    angle += 0.02f;
    if (angle > TWO_PI) { angle = 0; }
  }

  public void seek(PVector target) {
    acc.add(steer(target,false));
  }

  public void arrive(PVector target) {
    acc.add(steer(target,true));
  }

  // A method that calculates a steering vector towards a target
  // Takes a second argument, if true, it slows down as it approaches the target
  public PVector steer(PVector target, boolean slowdown) {
    PVector steer;  // The steering vector
    PVector desired = target.sub(target,loc);  // A vector pointing from the location to the target
    float d = desired.mag(); // Distance from the target is the magnitude of the vector
    // If the distance is greater than 0, calc steering (otherwise return zero vector)
    if (d > 0) {
      // Normalize desired
      desired.normalize();
      // Two options for desired vector magnitude (1 -- based on distance, 2 -- maxspeed)
      if ((slowdown) && (d < 100.0f)) desired.mult(maxspeed*(d/100.0f)); // This damping is somewhat arbitrary
      else desired.mult(maxspeed);
      // Steering = Desired minus Velocity
      steer = target.sub(desired,vel);
      steer.limit(maxforce);  // Limit to maximum steering force
    } 
    else {
      steer = new PVector(0,0);
    }
    return steer;
  }

  public void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = vel.heading2D() + PI/2;
    fill(200,100);
    noStroke();
    pushMatrix();
    translate(loc.x,loc.y, 1);
    ellipse(0, 0, w, w);
    rotate(theta);
    
    rotateX(-HALF_PI);
    translate(-w/2, -w * z ); 
    beginShape();
      texture(img);
      vertex(0, 0, 0, 0);
      vertex(w, 0, img.width, 0);
      vertex(w, w, img.width, img.height);
      vertex(0, w, 0, img.height);
      endShape();
      pushMatrix();
      {
        translate(w/2, 0, 1);
        rect(0, 0, 5, 5);
        rotate(diameter);
        image(hat, -w/2 -3, -36, w+15, w+15);
      }
      popMatrix();
    
    popMatrix();
  }

  // Wraparound
  public void borders() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  public PVector separate (ArrayList boids) {
    float desiredseparation = 20.0f;
    PVector steer = new PVector(0,0,0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (int i = 0 ; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      float d = PVector.dist(loc,other.loc);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(loc,other.loc);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  public PVector align (ArrayList boids) {
    float neighbordist = 25.0f;
    PVector steer = new PVector(0,0,0);
    int count = 0;
    for (int i = 0 ; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      float d = PVector.dist(loc,other.loc);
      if ((d > 0) && (d < neighbordist)) {
        steer.add(other.vel);
        count++;
      }
    }
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  public PVector cohesion (ArrayList boids) {
    float neighbordist = 25.0f;
    PVector sum = new PVector(0,0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (int i = 0 ; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      float d = loc.dist(other.loc);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.loc); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      return steer(sum,false);  // Steer towards the location
    }
    return sum;
  }
}



class FeedXml {
  final String feedUrl = "http://xmastree.randomwalks.org/tweets.xml";
  final String logoUrl = "http://a2.twimg.com/profile_images/1189387730/rw.jpg";
  final int getNum = 15;
  
  String[] getUrl        = new String[getNum];
  String[] getScreenName = new String[getNum];
  

  XMLElement xml;

  int numCount;
  int endNum = 0;

  FeedXml(PApplet app) {
    xml = new XMLElement(app, feedUrl);
    numCount = xml.getChildCount();
  }
  

  public String imgUrl() {
    String string = null;
    XMLElement[] picName = xml.getChildren("tweet/pic");
//    int startNum = picName.length - getNum;
//    for (int i = startNum; i < picName.length; i++) {
//      String url = picName[i].getContent();
//      if(url != null){
//        string = url;
//      }
//    }
//    return string;
    string = picName[0].getContent();
    return string;
  }

  public String name() {
    String string = null;
    XMLElement[] screenName = xml.getChildren("tweet/screen_name");
//    int startNum = screenName.length - getNum;
//    for (int i = startNum; i < screenName.length; i++) {
//      String url = screenName[i].getContent();
//      if(url != null){
//        string = url;
//      }
//    }
//    return string;
    string = screenName[0].getContent();
    return string;
  }
  
  public void getContents(){
    XMLElement[] screenName = xml.getChildren("tweet/screen_name");
    XMLElement[] picName = xml.getChildren("tweet/pic");

    if(screenName.length != 0) {
      
      if(screenName.length < 15)  endNum = screenName.length;
      if(screenName.length >= 15) endNum = screenName.length - (screenName.length - getNum);
      
      for (int i = 0; i < endNum; i++) {
        
        if(screenName[i] != null){
          String urlS = screenName[i].getContent();
          getScreenName[i] = urlS;     
        }else if(screenName[i] == null){
          getScreenName[i] = "randomwalks";
        }
        
        if(picName[i] != null){
          String urlP = picName[i].getContent();
          getUrl[i]        = urlP;
        }else if(picName[i] == null){
          getUrl[i] = logoUrl;
        }
        
      }
    }else if(screenName.length == 0){
      for (int i = 0; i < endNum; i++) {
        getUrl[i] = logoUrl;
      }
    }
  }
  
//  void update(){
//    xml = new XMLElement(app, feedUrl);
//    numCount = xml.getChildCount();
//  }
    

  public void checkPrint() {
    getContents();
//    println(getUrl);
//    println(getScreenName);
  }
}

// The Flock (a list of Boid objects)

class Flock {
  ArrayList boids; // An arraylist for all the boids

  Flock() {
    boids = new ArrayList(); // Initialize the arraylist
  }

  public void run() {
    
    for (int i = 0; i < boids.size(); i++) {
      Boid b = (Boid) boids.get(i);  
      b.run(boids);  // Passing the entire list of boids to each boid individually
      if(boids.size() >15){
        boids.remove(0);
      }
    }
//    println(boids.size());
  }

  public void addBoid(Boid b) {
    boids.add(b);
  }

}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#C0C0C0", "RW_event2" });
  }
}
