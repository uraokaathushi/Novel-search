class Comment < ApplicationRecord
  
  belongs_to :customer
  belongs_to :novel
  validates :comment, presence: true
  
end
