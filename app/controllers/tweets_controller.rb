# -*- encoding : utf-8 -*-
class TweetsController < ApplicationController
  def create
    @tweet = Tweet.new(params[:tweet])
    
    respond_to do |format|
      if @tweet.save
        format.json { render :json => {:status => true} }
      end
    end

  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @category = @tweet.category
    @tweet.destroy

    respond_to do |format|
      format.json {render :json => {:success => true}} 
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
