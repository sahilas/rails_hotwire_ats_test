class Profile < ApplicationRecord
validates_presence_of :name

  
   has_many :offers, dependent: :destroy
   has_many :members, dependent: :destroy
end
