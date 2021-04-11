class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :contact
      t.decimal :external_code

      t.timestamps
    end
  end
end
