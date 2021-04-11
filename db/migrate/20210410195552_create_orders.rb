class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :store_id
      t.integer :customer_id
      t.float :delivery_fee
      t.float :sub_total
      t.float :total_shipping
      t.float :total
      t.decimal :external_code
      t.string :status

      t.timestamps
    end
  end
end
