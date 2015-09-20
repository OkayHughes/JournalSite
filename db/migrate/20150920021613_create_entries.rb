class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :authors
      t.string :journal
      t.integer :volume
      t.string :pages
      t.date :published
      t.text :abstract
      t.string :doi
      t.string :filepath


      t.timestamps
    end
  end
end
