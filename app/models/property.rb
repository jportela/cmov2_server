class Property < ActiveRecord::Base
  has_attached_file :photo, :styles => { :normal => "400x400" }
end
