# -*- encoding : utf-8 -*-
class BranchesController < ApplicationController
  def new
    @branch = Branch.new
    
    respond_to do |format|
      format.html
    end

  end


  def index
    @branches = Branch.all
    
    respond_to do |format|
      format.html 
    end
  end
  
  def init
    @treedata = Treedata.last
    if @treedata
      @treedata.destroy
    end

    @branches = Branch.all
    
    if @branches
      @branches.each do |branch|
        branch.destroy
      end
    end


    @root = Branch.new
    @root.length = 150
    @root.rotation = 0
    @root.y = 0
    @root.scale = 1

    @root.save
    
    @leftBranch = Branch.new
    @leftBranch.length = Random.new.rand(100..@root.length)
    @leftBranch.rotation = Random.new.rand(-70..-30)
    @leftBranch.scale = Random.new.rand(0.7..0.99)
    @leftBranch.y = -@root.length
    @leftBranch.parent = @root
    @leftBranch.save


    @rightBranch = Branch.new
    @rightBranch.length = Random.new.rand(100..@root.length)
    @rightBranch.rotation = Random.new.rand(30..70)
    @rightBranch.scale = Random.new.rand(0.7..0.99)
    @rightBranch.y = -@root.length
    @rightBranch.parent = @root
    @rightBranch.save
    
    @centerBranch = Branch.new
    @centerBranch.length = Random.new.rand(100..@root.length)
    @centerBranch.rotation = 0
    @centerBranch.scale = Random.new.rand(0.7..0.99)
    @centerBranch.y = -@root.length
    @centerBranch.parent = @root
    @centerBranch.save

    @treedata = Treedata.new
    @treedata.branch = @root
    @treedata.centerbranch = @centerBranch
    @treedata.currentDepth = 1
    @treedata.save
    
    Branch.rebuild_depth_cache!


    respond_to do |format|
      format.html {redirect_to(branches_path, :notice => '초기화가 완료되었습니다.') }
    end


  end

  def create
    @treedata = Treedata.last

    @branch = @treedata.branch.subtree[Random.new.rand(0..@treedata.branch.subtree.count-1)]
    @branch.tweet = Tweet.find(params[tweet_id])
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

    respond_to do |format|
      format.html {redirect_to(branches_path, :notice => '성공적으로 등록되었습니다.') }
    end
  end

  def destroy
  end
end
