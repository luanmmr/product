class Periodicity < ApplicationRecord
  validates :name, :period, presence: true
  validates :name, inclusion: { in: %w[mensal trimestral semestral
                                       anual trienal] }
  validates :period, inclusion: { in: [1, 3, 6, 12, 36] }
  validates :period, numericality: { only_integer: true }
  validates :name, :period, uniqueness: true

  before_validation :normalize_name, on: %i[create update]
  before_validation :set_period, on: %i[create update]

  private

  def normalize_name
    self.name = name.downcase unless name.nil?
  end

  def set_period
    case name
    when 'mensal' then self.period = 1
    when 'trimestral' then self.period = 3
    when 'semestral' then self.period = 6
    when 'anual' then self.period = 12
    when 'trienal' then self.period = 36
    end
  end
end
