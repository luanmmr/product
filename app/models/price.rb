class Price < ApplicationRecord
  belongs_to :plan
  belongs_to :periodicity
  has_one :product_type, through: :plan

  validates :plan_price, :plan, :periodicity, presence: true
  validates :periodicity, uniqueness: { scope: :plan }
  validates :plan_price, numericality: true
end
