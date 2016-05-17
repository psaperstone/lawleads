class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :owner
      t.string :prop_str_addr
      t.string :prop_city
      t.string :prop_zip
      t.integer :assessed_value
      t.string :prop_acct_num
      t.text :legal_desc
      t.string :mail_str_addr
      t.string :mail_city
      t.string :mail_zip

      t.timestamps null: false
    end
  end
end
