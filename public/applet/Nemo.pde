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
    gravity = 0.1;
    diameter = tempD;
    
    this.url = url;
    img = loadImage(url);
    hat = loadImage("hat.png");
  }
  
    void move() {
    // Add gravity to speed
    speed = speed + gravity;
    // Add speed to y location
    y = y + speed;
    // If square reaches the bottom
    // Reverse speed
    if (y > height) {
      // Dampening
      speed = speed * -0.8;
      y = height;
    }
    
    diameter = sin(angle) / 4;
    angle += 0.02;
    if (angle > TWO_PI) { angle = 0; }
  }
  
  boolean finished() {
    // Balls fade out
    life--;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
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
