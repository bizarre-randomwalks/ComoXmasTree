# -*- encoding : utf-8 -*-
class CategoriesController < ApplicationController
  before_filter :find_question
  def show
    @category = Category.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @category = Category.new(params[:category])
    @category.question = @question
    
    respond_to do |format|
      if @category.save
        format.html { redirect_to(@question, :notice => '분류가 성공적으로 등록되었습니다.') }
      else
        format.html { redirect_to(@question) }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(@question, :notice => '분류가 성공적으로 삭제되었습니다.') }
    end
  end

  private
  def find_question
    @question = Question.find(params[:question_id])
  end
end
