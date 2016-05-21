class AddPropAndMailStateColumnsToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :prop_state, :string
    add_column :properties, :mail_state, :string
  end
end
