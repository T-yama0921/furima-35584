# テーブル設計

## usersテーブル

| Column           | Type      | Options     |
| ---------------- | --------- | ----------- |
| nickname         | string    | null: false |
| email            | string    | null: false, unique: true |
| encrypted_password | string  | null: false |
| last_name        | string    | null: false |
| first_name       | string    | null: false |
| last_name_kana   | string    | null: false |
| first_name_kana  | string    | null: false |
| birth_date       | date      | null: false |

### Association

- has_many :items
- has_many :purchase

## itemsテーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| item_name        | string     | null: false |
| description      | text       | null: false |
| category         | integer    | null: false |
| status           | integer    | null: false |
| shipping_charges | integer    | null: false |
| shipping_area    | integer    | null: false |
| shipping_days    | integer    | null: false |
| price            | integer    | null: false |
| user_id          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchasesテーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| card_number      | integer    | null: false |
| exp_month        | integer    | null: false |
| exp_year         | integer    | null: false |
| security_code    | integer    | null: false |
| user_id          | references | null: false, foreign_key: true |
| item_id          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| postal_code      | string     | null: false |
| prefecture       | integer    | null: false |
| city             | string     | null: false |
| house_number     | string     | null: false |
| building_name    | string     |             |
| phone_number     | integer    | null: false |
| purchase_id      | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase