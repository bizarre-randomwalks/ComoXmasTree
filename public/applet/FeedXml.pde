
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
  

  String imgUrl() {
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

  String name() {
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
  
  void getContents(){
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
    

  void checkPrint() {
    getContents();
//    println(getUrl);
//    println(getScreenName);
  }
}

