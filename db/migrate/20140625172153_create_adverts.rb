class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :kind
      t.string :state
      t.integer :user_id
      t.integer :category_id
      t.timestamps
    end
  end
end
