# -*- encoding : utf-8 -*-
class AdminsController < ApplicationController
  def index
    @tweets = Tweet.all
  end
  
  def deleteall
    @tweets = Tweet.all
    
    @tweets.each do |tweet|
      tweet.destroy
    end

    respond_to do |format|
      format.json {render :json => {:success => true}}
    end


  end

end
