class ProductType < ApplicationRecord
  has_many :plans, dependent: :destroy
  validates :name, :description, :product_key, presence: true
  validates :name, :product_key, uniqueness: true
  validates :product_key, length: { maximum: 8 }

  before_validation :normalize_name, on: %i[create update]
  before_validation :set_product_key, on: %i[create update]

  private

  def normalize_name
    return unless name

    self.name = name.downcase.capitalize
  end

  def set_product_key
    return if name.blank?

    name_no_space = name.delete(' ').upcase
    length_max = name_no_space.length - 1
    self.product_key = random_product_key(name_no_space, length_max)
  end

  def numbers_random
    "#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}"
  end

  def random_product_key(name_no_space, length_max)
    (name_no_space[0] + name_no_space[length_max / 2] +
    name_no_space[(length_max / 2) + 1] + name_no_space[length_max] +
    numbers_random.to_s).upcase
  end
end
