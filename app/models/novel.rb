class Novel < ApplicationRecord
  
    belongs_to :customer
    has_many :favorites
    has_many :comments, dependent: :destroy
    has_many :genres_select
    
end
