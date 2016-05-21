class RenameAssessedValueToHomeValue < ActiveRecord::Migration
  def change
    rename_column :properties, :assessed_value, :home_value
  end
end
