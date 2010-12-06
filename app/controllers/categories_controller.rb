# -*- encoding : utf-8 -*-
class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
    @tweets = Tweet.all
  end

  def show
    @category = Category.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @category = Category.new(params[:category])
    
    respond_to do |format|
      if @category.save
        format.html { redirect_to(categories_path, :notice => '분류가 성공적으로 등록되었습니다.') }
      else
        format.html { redirect_to(categories_path) }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_path, :notice => '분류가 성공적으로 삭제되었습니다.') }
    end
  end

end
