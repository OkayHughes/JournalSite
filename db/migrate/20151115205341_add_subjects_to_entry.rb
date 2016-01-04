class AddSubjectsToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :subjects, :string
  end
end
