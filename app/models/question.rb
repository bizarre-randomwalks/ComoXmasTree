# -*- encoding : utf-8 -*-
class Question < ActiveRecord::Base
  has_many :categories
  has_many :tweets
end
