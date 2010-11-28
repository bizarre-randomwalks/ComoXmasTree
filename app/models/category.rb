# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base
  belongs_to :question
  has_many :tweets
end
