xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
xml.tweets do
  @tweets.each do |tweet|
    xml.tweet do 
      xml.title(tweet.title)
      xml.screen_name(tweet.screen_name)
      xml.month(tweet.month)
      xml.status_id(tweet.status_id)
      xml.day(tweet.day)
      xml.created_at(tweet.created_at)
    end
  end
end
