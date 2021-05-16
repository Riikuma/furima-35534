# テーブル設計

## usersテーブル

| Column                | Type    | Options                   |
| --------------------- | ------- | ------------------------- |
| email                 | string  | null: false               |
| password              | string  | null: false               |
| nickname              | string  | null: false, unique: true |
| last_name             | string  | null: false               |
| first_name            | string  | null: false               |
| last_name_kana        | string  | null: false               |
| first_name_kana       | string  | null: false               |
| user_birth_date_year  | integer | null: false               |
| user_birth_date_month | integer | null: false               |
| user_birth_date_day   | integer | null: false               |

### Association

- has_many :items
- has_many :purchase_records

## itemsテーブル

| Column                   | Type       | Options           |
| ------------------------ | ---------- | ----------------- |
| item_name                | string     | null: false       |
| item_description         | text       | null: false       |
| item_category            | integer    | null: false       |
| item_status              | integer    | null: false       |
| item_shipping_fee_status | integer    | null: false       |
| item_prefecture          | integer    | null: false       |
| item_days_to_ship        | integer    | null: false       |
| item_price               | integer    | null: false       |
| seller_user              | references | foreign_key: true |

（item_image  ActiveStorageで実装）

### Association

- belongs_to :user
- has_one :purchase_record

## purchase_recordsテーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| buyer_user    | references | foreign_key: true |
| purchase_item | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addressesテーブル

| Column             | Type       | Options           |
| ------------------ | ---------- | ----------------- |
| buyer_postal_code  | string     | null: false       |
| buyer_prefecture   | integer    | null: false       |
| buyer_city         | string     | null: false       |
| buyer_address      | string     | null: false       |
| buyer_building     | string     |                   |
| buyer_phone_number | string     | null: false       |
| purchase_record    | references | foreign_key: true |

### Association

- belongs_to :purchase_record
