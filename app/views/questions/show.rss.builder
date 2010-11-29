xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
xml.rss(:version => "2.0") do
  xml.channel do
    xml.title("como xmas tree")
    xml.link(@question)
    xml.description(@question.title)
    xml.language("ko-KR")
    @tweets.each do |tweet|
      xml.item do
        xml.guid(tweet)
        xml.link(tweet)
        xml.title(tweet.title)
        xml.author(tweet.screen_name)
        xml.description(tweet.title)
	xml.category(tweet.category.title)
        xml.pubDate(tweet.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
      end
    end
  end
end
