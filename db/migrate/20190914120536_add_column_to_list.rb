class AddColumnToList < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :shared, :boolean, default: false
    add_column :lists, :collaborators, :text, array: true, default: []
  end
end
