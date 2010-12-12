import processing.core.*; 
import processing.xml.*; 

import processing.xml.XMLElement; 

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

public class rect_random_percent_test11 extends PApplet {



//import processing.xml.*;





float[] rns;
int [] rnsNum;
float [] newrns;
int [] greens;
int [] monthN;

int len=12;
int count;
int total=12;
int step;
int num;
int nlen;

PFont f;

XMLElement xml;
XMLElement [] xmls;
eachMonth[] months;



public void setup(){
  size(1200,100);

  rns=new float[len];
  rnsNum=new int [len];
  newrns=new float [len];
  greens=new int[len];
  monthN= new int [len];
  months= new eachMonth [len];
  xmls = new XMLElement [len];

  for (int i=0; i< len; i++){
    String thisMonth="http://xmastree.randomwalks.org/tweets/month.xml?q="+(i+1);
    xmls[i]= new XMLElement (this, thisMonth);
    int totaltweets = xmls[i].getChildCount();
    int [] days=new int[totaltweets];

    for (int j=0; j<days.length; j++){
      XMLElement eachtweet=xmls[i].getChild(j);
      int cnum=eachtweet.getChildCount();
      days[j] = PApplet.parseInt(eachtweet.getChild(4).getContent());
    }

    months[i]= new eachMonth(i+1,totaltweets, days);


  }

  reArrange();

  f=loadFont("TitilliumText22L-999wt-48.vlw");

  xml=new XMLElement(this,"date_test.xml");

  num = xml.getChildCount();
  for (int i =0; i < num; i++){
    XMLElement kid = xml.getChild(i);
    int cnum=kid.getChildCount();
  }

  for (int i=0; i<len; i++){
    monthN[i]=1;
  }

}

public void draw(){
  background(255,0,0);
  noStroke();

  if (step==0){
    len=12;
    total=0;

    for (int i=0; i<len; i++){
      monthN[i]=1;
    }


    reArrange();
    count++;
    if (count > 180){
      count=0;
      step=1;
    }
  } 
  else if (step==1){
    nlen=12;

    rns=new float[nlen];
    rnsNum=new int [nlen];
    newrns=new float [nlen];
    greens=new int[nlen];

    rightArrange();
    step=2;
  }
  else if(step==2){
    count++;
    if (count > 180){
      count=0;
      step=0;
    }
  }
  
  

for (int i=0; i<rns.length-1;i++){
  rectMode(CENTER);
  float d=abs(newrns[i]-newrns[i+1]);
  fill(0,greens[i],0);
  rect(newrns[i]+d*0.5f,height-d*0.5f,d,d);
  float fs=d*0.5f;
  fs=constrain(fs,5,20);
  textFont(f,fs);
  fill(255);
  textAlign(CENTER);
  float fh=height-d*0.5f;
  fh=constrain(fh,fs,height);
  text(i+1+"*",newrns[i]+d*0.5f,fh);
  textFont(f,10);
  text("this is test",newrns[i]+d*0.5f,fh+10);
}
  
    float d=abs(width-rns[11]);
    fill(0,greens[11], 0);
  rect(newrns[11]+d*0.5f, height-d*0.5f,d,d);
   float fs=d*0.5f;
  fs=constrain(fs,5,20);
  textFont(f,fs);
  textAlign(CENTER);
  fill(255);
   float fh=height-d*0.5f;
  fh=constrain(fh,fs,height);
  text(12+"*",newrns[11]+d*0.5f,fh);
  
}



public void reArrange(){
  
  rns[0]=0;

  for (int i=1; i<rns.length; i++){
    rns[i]=random(0,width);
    greens[i]=(int) map(rns[i],0,width,100,255);
  }

  for (int j=0; j<rns.length; j++){
    int myIndex=0;
    for (int i=0; i<rns.length; i++){
      if(rns[j] > rns[i]){
        myIndex++;
      } 
      rnsNum[j]=myIndex; 
    }
  }


  for (int j=0; j<rns.length; j++){
    for (int i=0; i<rns.length; i++){
      if(j==rnsNum[i]){
        newrns[j]=rns[i];

      } 
    }
  }
}


public void rightArrange(){

  counting();

  for (int i=0; i<rns.length; i++){
    float incr=width/total; 

    if (i==0){
      rns[i]=0;
    } 
    else{
      rns[i]=rns[i-1]+((months[i-1].mytweetlen)*incr);
    }
  }


  for (int i=0; i<rns.length; i++){

    newrns[i]=rns[i];
  }

  for (int i=0; i<rns.length-1; i++){
     float d=abs(newrns[i]-newrns[i+1]);
     greens[i]=(int) map(d,0,width,100,255);
  }

 float d=abs(newrns[11]-width);
     greens[11]=(int) map(d,0,width,100,255);


}

public void counting(){

  for (int i=0; i<months.length;i++){
    total+=months[i].mytweetlen;
  }

}




class eachMonth{
  

  int myMonth;
  String myXmlAdd;
  int mytweetlen;
  int[] mydays;
  
  int x,y,w;
  
  eachMonth(int myMonth_, int mytweetlen_, int mydays_[]){
  myMonth=myMonth_;
  mytweetlen=1+mytweetlen_;
  mydays=mydays_;
  }
  
  public void draw(){
    
    
  }
  
  
  
}



  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#C0C0C0", "rect_random_percent_test11" });
  }
}
