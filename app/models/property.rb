class Property < ActiveRecord::Base
  has_attached_file :photo, :styles => { :small => "100x100", :normal => "400x400" }
end
