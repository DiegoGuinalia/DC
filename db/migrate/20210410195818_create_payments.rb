class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :type
      t.float :value
      t.integer :order_id

      t.timestamps
    end
  end
end
