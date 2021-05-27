class Order
  include ActiveModel::Model
  attr_accessor :buyer_postal_code, :prefecture_id, :buyer_city, :buyer_address, :buyer_building, :buyer_phone_number,
                :token, :user_id, :item_id

  with_options presence: true do
    validates :token
    validates :buyer_postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'にはハイフン(-)を含めて半角数字で入力してください', allow_blank: true }
    validates :prefecture_id, numericality: { other_than: 1, message: 'には[---]以外を選択してください', allow_blank: true }
    validates :buyer_city, :buyer_address
    validates :buyer_phone_number, format: { with: /\A\d{10,11}\z/, message: 'には半角数字のみを用いて10桁もしくは11桁を入力してください', allow_blank: true }
    validates :user_id, :item_id
  end

  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(buyer_postal_code: buyer_postal_code, prefecture_id: prefecture_id, buyer_city: buyer_city,
                           buyer_address: buyer_address, buyer_building: buyer_building, buyer_phone_number: buyer_phone_number,
                           purchase_record_id: purchase_record.id)
  end
end
