require 'rails_helper'

feature 'User register price' do
  let(:user) { create(:user) }

  scenario 'successfully' do
    create(:periodicity)
    create(:plan)

    sign_in user, scope: :user
    visit root_path
    click_on 'Preços'
    click_on 'Add Preço'
    within 'form' do
      fill_in 'Preço do Plano', with: 59.90
      select 'Go', from: 'Plano'
      select 'Mensal', from: 'Periodicidade'
      click_button 'Criar Preço'
    end

    expect(page).to have_content('Go')
    expect(page).to have_content('Mensal')
    expect(page).to have_content(59.90)
  end

  scenario 'without entering the price' do
    sign_in user, scope: :user
    visit root_path
    click_on 'Preços'
    click_on 'Add Preço'
    within 'form' do
      click_button 'Criar Preço'
    end

    expect(page).to have_content('Preço do Plano não pode ficar em branco')
  end

  scenario 'and periodicity must be unique for a plan' do
    create(:price)

    sign_in user, scope: :user
    visit root_path
    click_on 'Preços'
    click_on 'Add Preço'
    within 'form' do
      fill_in 'Preço do Plano', with: 10
      select 'Go', from: 'Plano'
      select 'Mensal', from: 'Periodicidade'
      click_button 'Criar Preço'
    end

    expect(page).to have_content('Periodicidade já está em uso')
  end
end
