atom_feed do |feed|
  feed.title(@question.title)
  feed.updated(@question.updated_at)
 
  @question.tweets.each do |tweet|
    feed.entry(tweet) do |entry|
      entry.title(tweet.title)
      entry.content(tweet.title)
      entry.category(tweet.category.title)
      entry.updated(tweet.updated_at) # needed to work with Google Reader.
      entry.author do |author|
        author.name(tweet.screen_name)
      end
    end
  end
end
