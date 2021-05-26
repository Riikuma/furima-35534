class ShippingAddress < ApplicationRecord
  with_options presence: true do
    validates :buyer_postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'にはハイフン(-)を含めて入力してください', allow_blank: true }
    validates :prefecture_id, numericality: { other_than: 1, message: 'には[---]以外を選択してください', allow_blank: true }
    validates :buyer_city, :buyer_address
  end
  validates :buyer_building
  with_options presence: true do
    validates :buyer_phone_number, format: { with: /\A\d{10,11}\z/, message: 'には10桁もしくは11桁で入力してください', allow_blank: true }
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :purchase_record
end
