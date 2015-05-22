class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :institution
      t.boolean :mentor
      t.boolean :staff

      t.timestamps null: false
    end
  end
end
