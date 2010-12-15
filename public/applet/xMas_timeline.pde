

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
color[] colors = {color(#525151),color(#87AA59), color(#FFDA1F), color(#78FF1F),color(#525151),color(#87AA59), color(#FFDA1F), color(#78FF1F),color(#525151),color(#87AA59), color(#FFDA1F), color(#78FF1F),color(#525151),color(#87AA59), color(#FFDA1F), color(#78FF1F)};
String [] ms={"jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"};
PGraphics[] ps;

void setup(){
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
      days[j] = int(eachtweet.getChild(4).getContent());
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

void draw(){
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



void reArrange(){

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


void rightArrange(){

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

void counting(){

  for (int i=0; i<months.length;i++){
    total+=months[i].mytweetlen;
  }

}


void callRect(){
  
    for (int i=0; i<rns.length-1;i++){
    rectMode(CENTER);
    float d=abs(newrns[i]-newrns[i+1]);
    color c=color(0,greens[i],0);
    months[i].update(newrns[i]+d*0.5,height-d*0.5,d,c);
    months[i].draw();
    
    float fs=d*0.5;
    fs=constrain(fs,5,24);
    textFont(ft,fs);
    fill(255);
    textAlign(CENTER);
    float fh=height-d*0.5;
    fh=constrain(fh,fs,height);
    text(i+1+"*/",newrns[i]+d*0.5,fh);
    textFont(ft,fs*0.5);
    text("_____",newrns[i]+d*0.5,fh+fs*0.25);

  }

  float d=abs(width-rns[11]);
  color c=color(0,greens[11],0); 
  months[11].update(newrns[11]+d*0.5,height-d*0.5,d,c);
  months[11].draw();
 // rect(newrns[11]+d*0.5, height-d*0.5,d,d);
  float fs=d*0.5;
  fs=constrain(fs,5,20);
  textFont(ft,fs);
  textAlign(CENTER);
  fill(255);
  float fh=height-d*0.5;
  fh=constrain(fh,fs,height);
  text(12+"*/",newrns[11]+d*0.5,fh);
 textFont(ft,fs*0.5);
    text("_____",newrns[11]+d*0.5,fh+fs*0.25);
  
  
  
}




