class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :city
      t.string :state
      t.string :district
      t.string :street
      t.integer :order_id
      t.string :complement
      t.string :latitude
      t.string :longitude
      t.string :postal_code
      t.string :number

      t.timestamps
    end
  end
end
