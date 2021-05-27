class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.string     :buyer_postal_code,  null: false
      t.integer    :prefecture_id,      null: false
      t.string     :buyer_city,         null: false
      t.string     :buyer_address,      null: false
      t.string     :buyer_building
      t.string     :buyer_phone_number, null: false
      t.references :purchase_record,    foreign_key: true
      t.timestamps
    end
  end
end
