class AddDocumentnumToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :document_num, :string
    add_column :properties, :record_date, :date
    add_column :properties, :doc_number_lp, :string
    add_column :partials, :document_num, :string
    add_column :partials, :record_date, :date
    add_column :partials, :doc_number_lp, :string
  end
end
