class Genre < ApplicationRecord

   has_many :genres_select, dependent: :destroy
   has_many :novels, through: :genres_select

end
