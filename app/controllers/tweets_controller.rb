# -*- encoding : utf-8 -*-
class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @tweet = Tweet.find(params[:id])
    @tweet.category = Category.find(params[:category_id])
    
    
    respond_to do |format|
      if @tweet.save
        format.json { render :json => {:status => true, :title => @tweet.category.title} }
      end
    end

  end

  def create
    @tweet = Tweet.new
    @tweet.month = params[:month]
    @tweet.day = params[:day]
    @tweet.title = params[:memory]
    @tweet.screen_name = params[:screen_name]
    @tweet.status_id = params[:status_id]  
    
    
    respond_to do |format|
      if @tweet.save
        
        @treedata = Treedata.last

        @branch = @treedata.branch.subtree[Random.new.rand(0..@treedata.branch.subtree.count-1)]
        @branch.tweet = @tweet
        @branch.save

        
        @rightBranch = Branch.new
        @rightBranch.length = Random.new.rand(100..@branch.length)
        @rightBranch.rotation = Random.new.rand(30..70)
        @rightBranch.scale = Random.new.rand(0.7..0.99)
        @rightBranch.y = -@branch.length
        @rightBranch.parent = @branch
        @rightBranch.save
        
        
        @leftBranch = Branch.new
        @leftBranch.length = Random.new.rand(100..@branch.length)
        @leftBranch.rotation = Random.new.rand(-70..-30)
        @leftBranch.scale = Random.new.rand(0.7..0.99)
        @leftBranch.y = -@branch.length
        @leftBranch.parent = @branch
        @leftBranch.save


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
