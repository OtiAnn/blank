class Product < ActiveRecord::Base
  validates :name, :price, presence: true
  validates :name, confirmation: true
  validates :name_confirmation, presence: true
  validates :price,
    numericality: {
      greater_than: 0,
      less_than: 10000
    }
  belongs_to :category
end
