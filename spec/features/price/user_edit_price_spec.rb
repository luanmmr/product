require 'rails_helper'

feature 'User edit price' do
  let(:user) { create(:user) }

  scenario 'successfully' do
    price = create(:price)
    create(:periodicity, name: 'Trimestral')
    produto = create(:product_type, name: 'Email')
    create(:plan, name: 'Initial', product_type: produto)
    
    sign_in user, scope: :user
    visit root_path
    click_link 'Preços'
    within "tr#price-#{price.id}" do
      click_on 'Editar'
    end
    within 'form' do
      fill_in 'Preço do Plano', with: 20
      select 'Initial', from: 'Plano'
      select 'Trimestral', from: 'Periodicidade'
      click_on 'Atualizar Preço'
    end

    expect(page).to_not have_content(59.90)
    expect(page).to have_content('Trimestral')
    expect(page).to have_content('Initial')
  end

  scenario 'without entering the price' do
    price = create(:price)

    sign_in user, scope: :user
    visit root_path
    click_link 'Preços'
    within "tr#price-#{price.id}" do
      click_on 'Editar'
    end
    within 'form' do
      fill_in 'Preço do Plano', with: ''
      click_on 'Atualizar Preço'
    end

    expect(page).to have_content('Preço do Plano não pode ficar em branco')
  end

  scenario 'and periodicity must be unique for a plan' do
    price = create(:price)
    periodicidade = create(:periodicity, name: 'Trimestral')
    produto = create(:product_type, name: 'Email')
    plan = create(:plan, name: 'Initial', product_type: produto)
    create(:price, plan: plan, periodicity: periodicidade)
    

    sign_in user, scope: :user
    visit root_path
    click_link 'Preços'
    within "tr#price-#{price.id}" do
      click_on 'Editar'
    end
    within 'form' do
      select 'Initial', from: 'Plano'
      select 'Trimestral', from: 'Periodicidade'
      click_on 'Atualizar Preço'
    end

    expect(page).to have_content('Periodicidade já está em uso')
  end
end
