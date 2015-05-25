class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :content
      t.references :author, index: true

      t.timestamps null: false
    end

    add_foreign_key :announcements, :users, column: :author_id
  end
end
