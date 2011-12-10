class Property < ActiveRecord::Base
  has_many :discarded_properties
  has_many :users, :through => :discarded_properties
  
  has_attached_file :photo, :styles => { :small => "100x100", :normal => "400x400" }
end
