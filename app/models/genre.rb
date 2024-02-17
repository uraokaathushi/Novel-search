class Genre < ApplicationRecord

   has_many :genres_selects, dependent: :destroy
   has_many :novels, through: :genres_selects

end
