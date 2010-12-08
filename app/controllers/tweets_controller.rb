# -*- encoding : utf-8 -*-
class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
    respond_to do |format|
      format.html
      format.xml
    end
  end

  def month
    @tweets = Tweet.where("month = ?", params[:q])
    respond_to do |format|
      format.xml
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
    @tweet.pic = params[:pic]  
    
    
    respond_to do |format|
      if @tweet.save
        
        @treedata = Treedata.last

        @branch = treeSelect(@treedata)        
        @branch.tweet = @tweet
        @branch.save

        len = Random.new.rand(100..150)
        
        @rightBranch = Branch.new
        @rightBranch.scale = @branch.scale * Random.new.rand(0.7..0.99)
        @rightBranch.length = len * @rightBranch.scale
        @rightBranch.rotation = Random.new.rand(30..70)
        @rightBranch.y = -@branch.length
        @rightBranch.parent = @branch
        @rightBranch.save
        
        
        @leftBranch = Branch.new
        @leftBranch.scale = @branch.scale * Random.new.rand(0.8..0.9)
        @leftBranch.length = len * @leftBranch.scale
        @leftBranch.rotation = Random.new.rand(-70..-30)
        @leftBranch.y = -@branch.length
        @leftBranch.parent = @branch
        @leftBranch.save
        
        @treedata.currentTweet += 1
        @treedata.save

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

  private
  def treeSelect(treedata)
    
    if treedata.currentTweet > treedata.centerTweet - 1
      branch = treedata.centerbranch
      treedata.centerTweet = treedata.centerTweet * 2
      treedata.currentTweet = 0
      treedata.save
      timeToCenter = true
    else
      branch = treedata.branch.subtree[Random.new.rand(0..treedata.branch.subtree.count-1)]
      timeToCenter = false
    end

    logger.info 'branch.depth'
    logger.info branch.depth 
    logger.info 'branch.tweet'
    
    begin
      id = branch.tweet.id 
      existTweet = true
    rescue
      existTweet = false
      logger.info 'empty tweet'
    end


    if existTweet || branch.depth.to_s == "0" || (branch == treedata.centerbranch && !timeToCenter) 
      treeSelect(treedata)
    elsif branch == treedata.centerbranch && timeToCenter
      
      centerBranch = Branch.new
      centerBranch.scale = treedata.centerbranch.scale * Random.new.rand(0.7..0.99)
      centerBranch.length = branch.length
      centerBranch.rotation = 0
      centerBranch.y = -branch.length
      centerBranch.parent = branch
      centerBranch.save
      
      treedata.centerbranch = centerBranch
      treedata.save
    end

    return branch
    
  end


  def max(a, b)
    a > b ? a : b
  end
end
