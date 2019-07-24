class Photo < ApplicationRecord
  has_attached_file :image , keep_old_files: true , allow_destroy: true
  validates_attachment :image,
    content_type: { content_type: /\Aimage\/.*\z/ },
    size: { less_than: 1.megabyte }


  acts_as_votable


  # <------------------ADD ASSOCIATION------------------->


  belongs_to :user



end
