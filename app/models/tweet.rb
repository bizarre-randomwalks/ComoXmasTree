# -*- encoding : utf-8 -*-
class Tweet < ActiveRecord::Base
  belongs_to :category
  belongs_to :question
end
