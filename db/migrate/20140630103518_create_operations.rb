class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.integer :advert_id
      t.integer :user_id
      t.string :from
      t.string :to
      t.timestamps
    end
  end
end
