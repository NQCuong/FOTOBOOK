class Album < ApplicationRecord
# <------------------ADD ASSOCIATION------------------->
  belongs_to :user
  has_many :album_images
end
