# -*- encoding : utf-8 -*-
class Tweet < ActiveRecord::Base
  belongs_to :category
  has_one :branch, :dependent => :destroy
end
