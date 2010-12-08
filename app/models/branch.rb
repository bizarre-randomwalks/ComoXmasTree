# -*- encoding : utf-8 -*-
class Branch < ActiveRecord::Base
  has_ancestry :cache_depth => true
  belongs_to :tweet
  
end
