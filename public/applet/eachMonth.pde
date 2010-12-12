class eachMonth{


  int myMonth;
  String myXmlAdd;
  int mytweetlen;
  int[] mydays;
  color myc;
  int index;

  float mysq;
  float eachsqrt;
  int purelen;
  int[] fullmonth;
  int dayslen;

  float x,y,w,h;
  
  color myMonthColor;


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

  void draw(){

    colorMode(RGB);

    fill(myc);

    rect(x,y,w,w);


  }
  
   
  void update(float x_, float y_, float w_, color c_){
    x=x_;
    y=y_;
    w=w_;
    h=w_;


    if(w_> height){
      h=height;
    }

    ps[index].width=int(w);
    ps[index].height=int(h);



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
  
  void writeMonth(){
    

  }
    

  void calender(){

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
     float mymc=map(myMonth,1,12,0.0,1.0);
     color from=lerpColor(color(#F7FF1F), color(#FF1F1F),mymc);
     color to = lerpColor(color(#188311), color(#FFEA00),yellow);
     //color fc=lerpColor(from, to, yellow);
     ps[index]. fill(255-yellow,0,255-yellow);
     float fontsize=map(fullmonth[i],0,mytweetlen,12,25);
      ps[index].textFont(f,fontsize);
      ps[index].rect(px,py,eachsqrt*(fullmonth[i]),eachsqrt*fullmonth[i]);
     
     ps[index].fill(255);
     float cx=x+eachsqrt*fullmonth[i]*0.5;
     float cy=y+eachsqrt*fullmonth[i]*0.5;
      ps[index].textAlign(LEFT);
     ps[index].text(i,px,py+fontsize);
     
     
     px+=eachsqrt*fullmonth[i];
     if (px > w){
     py+=eachsqrt;
     px=0;
     }
     
     }
     }
     
     float bigtx=constrain(w*0.5,10,130);
     
         ps[index].textFont(ft,bigtx);
      ps[index].textAlign(RIGHT);
    ps[index].text(ms[myMonth-1]+".",w+15,h);

 
   ps[index].endDraw();
   
        image(ps[index],x-w*0.5,height-h,w,h);


  }

}





