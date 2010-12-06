# -*- encoding : utf-8 -*-
class Branchconnection < ActiveRecord::Base
  belongs_to :brancher, :class_name => 'Branch'
  belongs_to :branchee, :class_name => 'Branch'
end
