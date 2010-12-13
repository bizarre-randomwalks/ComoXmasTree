
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

  String imgUrl() {
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

  String name() {
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
  
  void getContents(){
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
    

  void checkPrint() {
    getContents();
//    println(getUrl);
//    println(getScreenName);
  }
}

