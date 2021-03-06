require 'rails_helper'

feature 'Visitant sign up' do
  scenario 'sucessfully' do
    visit root_path
    click_on 'Cadastre-se'
    within 'form' do
      fill_in 'Email', with: 'devise@devise.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmar Senha', with: '123456'
      click_on 'Cadastrar'
    end

    expect(current_path).to eq(root_path)
  end

  scenario 'with blank email' do
    visit root_path
    click_on 'Cadastre-se'
    click_on 'Cadastrar'

    expect(page).to have_content('Email não pode ficar em branco')
  end

  scenario 'with blank password' do
    visit root_path
    click_on 'Cadastre-se'
    click_on 'Cadastrar'

    expect(page).to have_content('Senha não pode ficar em branco')
  end

  scenario 'with invalid email' do
    visit root_path
    click_on 'Cadastre-se'
    within 'form' do
      fill_in 'Email', with: 'devise'
      click_on 'Cadastrar'
    end

    expect(current_path).to eq(user_registration_path)
  end

  scenario 'with unsatisfactory number of characters' do
    visit root_path
    click_on 'Cadastre-se'
    within 'form' do
      fill_in 'Senha', with: '12345'
      click_on 'Cadastrar'
    end

    expect(page).to have_content('Senha é muito curto(a)')
  end

  scenario 'with password confirmation other than password' do
    visit root_path
    click_on 'Cadastre-se'
    within 'form' do
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmar Senha', with: '654321'
      click_on 'Cadastrar'
    end

    expect(page).to have_content('Confirmação de Senha não é igual a Senha')
  end
end
