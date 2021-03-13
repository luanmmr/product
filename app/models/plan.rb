class Plan < ApplicationRecord
  belongs_to :product_type
  has_many :prices, dependent: :destroy

  enum status: { activated: 0, disabled: 5 }
  validates :name, :description, :details, :status, presence: true
  validates :name, uniqueness: true
end
