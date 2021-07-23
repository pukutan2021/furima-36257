# テーブル設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association

- has_many :items

## items テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| name     | string     | null: false                    |
| text     | text       | null: false                    |
| category | text       | null: false                    |
| status   | text       | null: false                    |
| price    | integer    | null: false                    |
| user     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column        | Type       | Options                         |
| ------------- | ---------- | ------------------------------- |
| postal_code   | string     | null: false                     |
| prefecture    | integer    | null: false                     |
| city          | string     | null: false                     |
| house_number  | string     | null: false                     |
| building_name | string     |                                 |
| phone_number  | string     | null: false                     |
| item          | references | null: false , foreign_key: true |
| user          | references | null: false , foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item