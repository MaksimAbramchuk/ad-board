class AddPhotoToAdvert < ActiveRecord::Migration
  def change
    def self.up
      add_column :adverts, :photo_file_name, :string # Original filename
      add_column :adverts, :photo_content_type, :string # Mime type
      add_column :adverts, :photo_file_size, :integer # File size in bytes
    end

    def self.down
      remove_column :adverts, :photo_file_name
      remove_column :adverts, :photo_content_type
      remove_column :adverts, :photo_file_size
    end 
  end
end
