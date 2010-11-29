atom_feed do |feed|
  feed.title(@question.title)
  feed.updated(@question.updated_at)
 
  @tweets.each do |tweet|
    feed.entry(tweet) do |entry|
      entry.title(tweet.title)
      entry.content(tweet.title)
      entry.category(tweet.category.title)
      entry.author do |author|
        author.name(tweet.screen_name)
      end
    end
  end
end
