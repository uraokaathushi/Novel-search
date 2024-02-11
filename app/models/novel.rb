class Novel < ApplicationRecord
  
    belongs_to :customer
    has_many :favorites
    has_many :comments
    has_many :genres_select
    
end
