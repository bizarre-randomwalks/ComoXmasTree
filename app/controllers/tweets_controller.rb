class TweetsController < ApplicationController
  def create
    @tweet = Tweet.new(params[:tweet])
    
    respond_to do |format|
      if @tweet.save
        format.json { render :json => {:status => true} }
      end
    end

  end

  def already_posted
    @tweet = Tweet.find_by_status_id(params[:status_id])

    respond_to do |format|
      if @tweet
        format.json { render :json => {:posted => true} } 
      else
        format.json { render :json => {:posted => false} } 
      end
    end
  end
end
