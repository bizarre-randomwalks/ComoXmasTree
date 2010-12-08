# -*- encoding : utf-8 -*-
class Treedata < ActiveRecord::Base
  belongs_to :branch
  belongs_to :centerbranch, :class_name => 'Branch'
end
