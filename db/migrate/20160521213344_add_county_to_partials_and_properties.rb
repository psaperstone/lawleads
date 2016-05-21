class AddCountyToPartialsAndProperties < ActiveRecord::Migration
  def change
    add_column :properties, :prop_county, :string
    add_column :properties, :mail_county, :string
    add_column :partials, :prop_county, :string
    add_column :partials, :mail_county, :string
  end
end
