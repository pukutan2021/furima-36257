# テーブル設計

## users テーブル

| Column              | Type    |  Options    |
| ------------------- | ------- | ----------- |
| nickname            | string  | null: false |
| email               | string  | null: false |
| encrypted_password  | string  | null: false |
| last_name           | string  | null: false |
| first_name          | string  | null: false |
| last_name_kana      | string  | null: false |
| first_name_kane     | string  | null: false |
| user_birth_date(1i) | integer | null: false |
| user_birth_date(2i) | integer | null: false |
| user_birth_date(3i) | integer | null: false |

### Association

- has_many :items
- has_one :order

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| info            | text       | null: false                    |
| category_id     | text       | null: false                    |
| sales_status_id | text       | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :pay_form

## pay_forms テーブル

| Column       | Type       | Options                         |
| ------------ | ---------- | ------------------------------- |
| postal_code  | string     | null: false                     |
| prefecture   | integer    | null: false                     |
| city         | string     | null: false                     |
| addresses    | string     | null: false                     |
| building     | string     |                                 |
| phone_number | string     | null: false                     |
| order        | references | null: false , foreign_key: true |

### Association

- belongs_to :order