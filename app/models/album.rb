class Album < ApplicationRecord
  acts_as_votable
# <------------------ADD ASSOCIATION------------------->
  belongs_to :user
  has_many :album_images
end
