atom_feed do |feed|
  feed.title(@question.title)
  feed.updated(@question.tweets.last.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))
 
  @question.tweets do |tweet|
    feed.entry(tweet) do |entry|
      entry.title(tweet.title)
      entry.content(tweet.title)
      entry.updated(tweet.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) # needed to work with Google Reader.
      entry.author do |author|
        author.name(tweet.screen_name)
      end
    end
  end
end