import processing.core.*; 
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

public class xMas_timeline extends PApplet {



//import processing.xml.*;
//import processing.xml.XMLElement;




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
int monthcount=9;

PFont f,ft;

XMLElement xml;
XMLElement [] xmls;
eachMonth[] months;

int[] fulldays = {31,28,31,30,31,30,31,31,30,31,30,31};
int[] colors = {color(0xff525151),color(0xff87AA59), color(0xffFFDA1F), color(0xff78FF1F),color(0xff525151),color(0xff87AA59), color(0xffFFDA1F), color(0xff78FF1F),color(0xff525151),color(0xff87AA59), color(0xffFFDA1F), color(0xff78FF1F),color(0xff525151),color(0xff87AA59), color(0xffFFDA1F), color(0xff78FF1F)};
String [] ms={"jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"};
PGraphics[] ps;

public void setup(){
  size(1200,100);
  frameRate(30);

  rns=new float[len];
  rnsNum=new int [len];
  newrns=new float [len];
  greens=new int[len];
  monthN= new int [len];
  months= new eachMonth [len];
  xmls = new XMLElement [len];
  ps=new PGraphics[len];
  
  smooth();

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

    months[i]= new eachMonth(i+1,totaltweets, days, fulldays[i]);


  }

  reArrange();

  f=loadFont("TitilliumText22L-999wt-48.vlw");
  ft=loadFont("AmeriGarmnd-BTItalic-140.vlw");


  for (int i=0; i<len; i++){
    monthN[i]=1;
    ps[i]=createGraphics(width,height,P2D);
  }
  


}

public void draw(){
  colorMode(RGB);
  background(255,0,0);
  noStroke();

  if (step==0){
    len=12;
    total=0;

    for (int i=0; i<len; i++){
      monthN[i]=1;
    }


    reArrange();
    
    callRect();


    count++;
    if (count > 15){
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
    
    callRect();

  }
  else if(step==2){
    
  callRect();

//for (int i=0; i<months.length; i++){
if(months[monthcount].mytweetlen==1){
  monthcount++;
}

println(monthcount);

for (int i=0; i<12;i++){
months[i].calender();
}
//}
    
    count++;
    if (count > 120){
      count=0;
      step=0;
      monthcount++;
     if (monthcount>11){
        monthcount=0;
      }
    }
  }



}



public void reArrange(){

  rns[0]=0;
  greens[0]=(int) random(10,255);

  for (int i=1; i<rns.length; i++){
    rns[i]=random(0,width);
    greens[i]=(int) map(rns[i],0,width,10,255);
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
 greens[i]=(int) map(i*d,0,width,50,200);
 if (greens[i]>200){
   greens[i]=200;
 }
 
 //greens[i]=(int) random(80,255);
  }

  float d=abs(newrns[11]-width);
 greens[11]=(int) map(11*d,0,width,50,200);

}

public void counting(){

  for (int i=0; i<months.length;i++){
    total+=months[i].mytweetlen;
  }

}


public void callRect(){
  
    for (int i=0; i<rns.length-1;i++){
    rectMode(CENTER);
    float d=abs(newrns[i]-newrns[i+1]);
    int c=color(0,greens[i],0);
    months[i].update(newrns[i]+d*0.5f,height-d*0.5f,d,c);
    months[i].draw();
    
    float fs=d*0.5f;
    fs=constrain(fs,5,24);
    textFont(ft,fs);
    fill(255);
    textAlign(CENTER);
    float fh=height-d*0.5f;
    fh=constrain(fh,fs,height);
    text(i+1+"*/",newrns[i]+d*0.5f,fh);
    textFont(ft,fs*0.5f);
    text("_____",newrns[i]+d*0.5f,fh+fs*0.25f);

  }

  float d=abs(width-rns[11]);
  int c=color(0,greens[11],0); 
  months[11].update(newrns[11]+d*0.5f,height-d*0.5f,d,c);
  months[11].draw();
 // rect(newrns[11]+d*0.5, height-d*0.5,d,d);
  float fs=d*0.5f;
  fs=constrain(fs,5,20);
  textFont(ft,fs);
  textAlign(CENTER);
  fill(255);
  float fh=height-d*0.5f;
  fh=constrain(fh,fs,height);
  text(12+"*/",newrns[11]+d*0.5f,fh);
 textFont(ft,fs*0.5f);
    text("_____",newrns[11]+d*0.5f,fh+fs*0.25f);
  
  
  
}




class eachMonth{


  int myMonth;
  String myXmlAdd;
  int mytweetlen;
  int[] mydays;
  int myc;
  int index;

  float mysq;
  float eachsqrt;
  int purelen;
  int[] fullmonth;
  int dayslen;

  float x,y,w,h;
  
  int myMonthColor;


  eachMonth(int myMonth_, int mytweetlen_, int mydays_[], int dayslen_){
    myMonth=myMonth_;
    index=myMonth-1;
    mytweetlen=1+mytweetlen_;
    mydays=mydays_;
    dayslen=dayslen_;
    myMonthColor=colors[myMonth-1];


    fullmonth=new int[dayslen];
    for (int i=0; i<fullmonth.length; i++){
      fullmonth[i]=0;
    }
  }

  public void draw(){

    colorMode(RGB);

    fill(myc);

    rect(x,y,w,w);


  }
  
   
  public void update(float x_, float y_, float w_, int c_){
    x=x_;
    y=y_;
    w=w_;
    h=w_;


    if(w_> height){
      h=height;
    }

    ps[index].width=PApplet.parseInt(w);
    ps[index].height=PApplet.parseInt(h);



    myc=c_;
    mysq=w*h;
    eachsqrt=(int) sqrt(mysq/mytweetlen);

    //dupulicated day

    for (int i=0; i<fullmonth.length; i++){
      int dupday=0;
      for (int j=0; j<mydays.length; j++){
        if (i==mydays[j]){
          dupday++;
        }
      }
      fullmonth[i]=dupday;
    }
  }
  
  public void writeMonth(){
    

  }
    

  public void calender(){

    float px=0;
    float py=0;
    if (w > height){
      py=0;
    }

    ps[index].beginDraw();
   ps[index].noStroke();
    ps[index].background(myc);
    
 


   
    for (int i=0; i<fullmonth.length;i++){
     if(fullmonth[i]!=0){
    colorMode(HSB);
     float yellow=map(fullmonth[i],0,mytweetlen,150,255);
     float mymc=map(myMonth,1,12,0.0f,1.0f);
     int from=lerpColor(color(0xffF7FF1F), color(0xffFF1F1F),mymc);
     int to = lerpColor(color(0xff188311), color(0xffFFEA00),yellow);
     //color fc=lerpColor(from, to, yellow);
     ps[index]. fill(255-yellow,0,255-yellow);
     float fontsize=map(fullmonth[i],0,mytweetlen,12,25);
      ps[index].textFont(f,fontsize);
      ps[index].rect(px,py,eachsqrt*(fullmonth[i]),eachsqrt*fullmonth[i]);
     
     ps[index].fill(255);
     float cx=x+eachsqrt*fullmonth[i]*0.5f;
     float cy=y+eachsqrt*fullmonth[i]*0.5f;
      ps[index].textAlign(LEFT);
     ps[index].text(i,px,py+fontsize);
     
     
     px+=eachsqrt*fullmonth[i];
     if (px > w){
     py+=eachsqrt;
     px=0;
     }
     
     }
     }
     
     float bigtx=constrain(w*0.5f,10,130);
     
         ps[index].textFont(ft,bigtx);
      ps[index].textAlign(RIGHT);
      
      if(mytweetlen >1){
   ps[index].text(ms[myMonth-1]+".",w+15,h);
      } 
      else{
     float fs=w*0.5f;
    fs=constrain(fs,5,20);
    ps[index]. textFont(ft,fs);
     ps[index].fill(255);
     ps[index].textAlign(CENTER);
    float fh=h-h*0.5f;
    fh=constrain(fh,fs,h);
     ps[index].text(myMonth+1+"*/",px+w*0.5f,py+h*0.5f);
    ps[index]. textFont(ft,fs*0.75f);
     ps[index].text("_ _ _",px+w*0.5f,py+h*0.5f+5);
    
      }
       

 
   ps[index].endDraw();
   
        image(ps[index],x-w*0.5f,height-h,w,h);


  }

}





/*










newrns[0]= 0.0
newrns[1]= 27.0
newrns[2]= 54.0
newrns[3]= 81.0
newrns[4]= 108.0
newrns[5] =135.0
newrns[6] =189.0
newrns[7]= 351.0
newrns[8]= 513.0
newrns[9]= 567.0
newrns[10]= 1026.0
newrns[11] =1107.0

*/


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "xMas_timeline" });
  }
}
