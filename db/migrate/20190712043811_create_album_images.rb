class CreateAlbumImages < ActiveRecord::Migration[5.2]
  def change
    create_table :album_images do |t|
      t.attachment :image

      t.timestamps
    end
  end
end
