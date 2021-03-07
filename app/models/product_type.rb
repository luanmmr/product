class ProductType < ApplicationRecord
  validates :name, :description, :product_key, presence: true
  validates :name, :product_key, uniqueness: true

  before_validation :normalize_name, on: :create
  before_validation :generate_product_key, on: :create

  private

  def normalize_name
    self.name = name.downcase unless name.nil?
  end

  def generate_product_key
    return false if name.nil?
    length_max = name.length - 1
    none_space = name.delete(' ').upcase
    self.product_key = (name[0] + name[length_max / 2] + 
                        name[(length_max / 2) + 1] + 
                        name[length_max] + 
                        "#{numbers_random}").upcase
  end

  def numbers_random
    "#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}"
  end
end
