require 'rails_helper'

RSpec.describe Periodicity, type: :model do
  describe '#presence' do
    it 'validates every field must be filled' do
      periodicity = described_class.new(name: nil, period: nil)

      periodicity.valid?

      expect(periodicity.errors.full_messages).to include(
        'Nome não pode ficar em branco',
        'Período não pode ficar em branco'
      ) 
    end
  end

  describe  '#inclusion' do
    it 'validates if name is included in the list' do
      periodicity = described_class.new(name: 'teste')

      periodicity.valid?

      expect(periodicity.errors.full_messages).to include(
        'Nome não está incluído na lista'
      )
    end

    it 'validates if period is included in the list' do
      periodicity = described_class.new(period: 2)

      periodicity.valid?

      expect(periodicity.errors.full_messages).to include(
        'Período não está incluído na lista'
      )
    end
  end

  describe '#numericality' do
    it 'validates if period is a number' do
      periodicity = Periodicity.new(period: 'teste')

      periodicity.valid?

      expect(periodicity.errors.full_messages).to include(
        'Período não é um número'
      )
    end
  end

  describe '#uniqueness' do
    it 'validates if name is single' do
      create(:periodicity)
      periodicity = Periodicity.new(name: 'mensal')

      periodicity.valid?

      expect(periodicity.errors.full_messages).to include(
        'Nome já está em uso'
      )
    end

    it 'validates if period is single' do
      create(:periodicity)
      periodicity = Periodicity.new(period: 1)

      periodicity.valid?

      expect(periodicity.errors.full_messages).to include(
        'Período já está em uso'
      )
    end
  end

  describe '#normalize_name' do
    it 'normalize name in downcase' do
      periodicity = Periodicity.new(name: 'MENSAL')

      periodicity.valid?

      expect(periodicity.name).to eq('mensal')
    end
  end

  describe '#set_period' do
    it 'set period after defined month' do
      periodicity = Periodicity.new(name: 'mensal')

      periodicity.valid?

      expect(periodicity.period).to eq(1)
    end

    it 'set period after defined quarterly' do
      periodicity = Periodicity.new(name: 'trimestral')

      periodicity.valid?

      expect(periodicity.period).to eq(3)
    end

    it 'set period after defined semiannual' do
      periodicity = Periodicity.new(name: 'semestral')

      periodicity.valid?

      expect(periodicity.period).to eq(6)
    end

    it 'set period after defined annual' do
      periodicity = Periodicity.new(name: 'anual')

      periodicity.valid?

      expect(periodicity.period).to eq(12)
    end

    it 'set period after defined triennial' do
      periodicity = Periodicity.new(name: 'trienal')

      periodicity.valid?

      expect(periodicity.period).to eq(36)
    end
  end
end
