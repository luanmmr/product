require 'rails_helper'

RSpec.describe ProductType, type: :model do
  describe '#presence' do
    it 'validates every field must be filled' do
      product = described_class.new(name: nil, description: nil)

      product.valid?

      expect(product.errors.full_messages).to include(
        'Nome não pode ficar em branco',
        'Descrição não pode ficar em branco'
      )
    end
  end

  describe '#uniqueness' do
    it 'validate if name is single' do
      create(:product_type)
      product = described_class.new(name: 'Hospedagem')

      product.valid?

      expect(product.errors.full_messages).to include(
        'Nome já está em uso'
      )
    end
  end

  describe '#length' do
    it 'validate name has maximum length' do
      product_one = create(:product_type)
      product_other = ProductType.create(name: 'Email',
                                         description: 'Este é um '\
                                         'serviço de emails')

      expect(product_one.product_key.length).to eq(8)
      expect(product_other.product_key.length).to eq(8)
    end
  end
end
