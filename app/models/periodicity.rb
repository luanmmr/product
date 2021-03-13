class Periodicity < ApplicationRecord
  validates :name, :period, presence: true
  validates :name, inclusion: { in: %w[Mensal Trimestral Semestral
                                       Anual Trienal] }
  validates :period, inclusion: { in: [1, 3, 6, 12, 36] }
  validates :period, numericality: { only_integer: true }
  validates :name, :period, uniqueness: true

  before_validation :normalize_name, on: %i[create update]
  before_validation :set_period, on: %i[create update]

  private

  def normalize_name
    return unless name

    self.name = name.downcase.capitalize
  end

  def set_period
    case name
    when 'Mensal' then self.period = 1
    when 'Trimestral' then self.period = 3
    when 'Semestral' then self.period = 6
    when 'Anual' then self.period = 12
    when 'Trienal' then self.period = 36
    end
  end
end
