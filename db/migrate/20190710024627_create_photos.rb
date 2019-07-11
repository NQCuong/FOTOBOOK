class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :title
      t.attachment :image
      t.string :description

      t.timestamps
    end
  end
end
