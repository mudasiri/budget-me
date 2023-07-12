class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :category_payments, dependent: :destroy
  has_many :payments, through: :category_payments, dependent: :destroy
  # has_many :payments, dependent: :destroy
  has_one_attached :icon, dependent: :destroy

  validates :name, :icon, presence: true
end
