class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|

      t.timestamps
    end
  end
end
