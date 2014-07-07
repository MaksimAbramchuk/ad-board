class AddAvatarToUser < ActiveRecord::Migration
  def change
    add_column :images, :imageable_id, :integer
    add_column :images, :imageable_type, :string
    remove_column :images, :advert_id, :integer
  end
end
