require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe '#presence' do
    it 'validates every field must be filled' do
      plan = described_class.new()

      plan.valid?

      expect(plan.errors.full_messages).to include(
        'Nome não pode ficar em branco',
        'Descrição não pode ficar em branco',
        'Detalhes não pode ficar em branco',
        'Status não pode ficar em branco'
      )
    end
  end

  describe '#uniqueness' do
    it 'validates if name is unique' do
      create(:plan)
      plan = described_class.new(name: 'Go')

      plan.valid?

      expect(plan.errors.full_messages).to include (
        'Nome já está em uso'
      )
    end
  end

  describe '#activate' do
    it 'validate if plano is activated' do
      plan = create(:plan, status: :disabled)

      plan.activated!

      expect(plan.status).to eq('activated')
    end
  end

  describe '#deactivate' do
    it 'validate if plano is disabled' do
      plan = create(:plan)

      plan.disabled!

      expect(plan.status).to eq('disabled')
    end
  end
end
