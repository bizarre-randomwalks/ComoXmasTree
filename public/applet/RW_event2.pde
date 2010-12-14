import processing.xml.*;

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
void setup() {
  size(300, 300, P3D);
  flock = new Flock();

  Fxml = new FeedXml(this);
  Fxml.checkPrint();

  // Add an initial set of boids into the system
  for(int i = 0; i < Fxml.endNum; i++) {
    //    println(Fxml.getUrl[i]);
    flock.addBoid(new Boid(
    new PVector(
    random(width), height/2), 3.0, 0.05, Fxml.getUrl[i]) );
  }

  bgImg = loadImage("bg.jpg");
  background(252, 115, 202);
}

void draw() {
  background(252, 115, 202);
  image(bgImg, -150, -150, 600, 600);

  //  ortho(0, width, 0, height, -1000, 1000);
  ortho(-width * 0.5, width * 0.5, -height * 0.5, height * 0.5, -1000, 1000);
  camera(500.0, 0.0, 300.0,
  width/2, height/2, 0,
  0, 0, -1);

  flock.run();
  picUpdate();
}


void picUpdate() {
  float m = (millis() * 0.05) % 1500;
//  println(int(m) +" "+second());

  if( int(m) == 0) {
//    println("update");
    Fxml = new FeedXml(this);

    if(Fxml.numCount != pre_url) {
      //      println("on");
      flock.addBoid(new Boid(new PVector(10, 10), 2.0f, 0.05f, Fxml.imgUrl() ));
    }
    pre_url = Fxml.numCount;
  }
}

