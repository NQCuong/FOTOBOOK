class AddFieldsToUSers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstname, :string ,:before => :email
    add_column :users, :lastname, :string ,:before => :firstname
  end

  remove_column :users, :lasttname, :string

end
