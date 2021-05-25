class Item < ApplicationRecord
  with_options presence: true do
    validates :item_image
    validates :item_name, length: { maximum: 40, message: 'には40文字以内で入力してください', allow_blank: true }
    validates :item_description, length: { maximum: 1000, message: 'には1000文字以内で入力してください', allow_blank: true }
    with_options numericality: { other_than: 1, message: 'には[---]以外を選択してください', allow_blank: true } do
      validates :item_category_id, :item_status_id, :item_shipping_fee_status_id, :prefecture_id, :item_days_to_ship_id
    end
    validates :item_price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                                           message: 'には半角数字を300~9999999の範囲で入力してください', allow_blank: true }
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_status
  belongs_to :item_shipping_fee_status
  belongs_to :prefecture
  belongs_to :item_days_to_ship
  belongs_to :user
  has_one_attached :item_image
end
