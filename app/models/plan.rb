class Plan < ApplicationRecord
  belongs_to :product_type
  has_many :prices, dependent: :destroy

  enum status: { activated: 0, disabled: 5 }
  validates :name, :description, :details, :status, presence: true
  validates :name, uniqueness: true

  before_validation :normalize_name, on: %i[create update]

  private

  def normalize_name
    return unless name
    
    self.name = name.downcase.capitalize
  end
end
