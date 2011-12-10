class User < ActiveRecord::Base
  has_many :discarded_properties
  has_many :properties, :through => :discarded_properties
end
