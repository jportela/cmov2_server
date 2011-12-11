class User < ActiveRecord::Base
  has_many :discarded_properties
  has_many :properties, :through => :discarded_properties
  
  def items
    Property.find_by_sql ['SELECT "properties".* FROM "properties"
                          WHERE "properties"."state" = "for sale" AND id NOT IN
                                (SELECT "discarded_properties"."property_id" FROM "discarded_properties" 
                                WHERE "discarded_properties"."user_id" = ?)', self.id ]
  end
  
end
