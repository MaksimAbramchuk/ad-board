class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment
      t.integer :advert_id 
      t.integer :operation_id
      t.timestamps
    end
  end
end
