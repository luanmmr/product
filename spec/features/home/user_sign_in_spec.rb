require 'rails_helper'

feature 'User sign in' do
  scenario 'sucessfully' do
    create(:user)

    visit root_path
    within 'form' do
      fill_in 'Email', with: 'devise@devise.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    expect(current_path).to eq(root_path)
  end

  scenario 'failure' do
    visit root_path
    within 'form' do
      fill_in 'Email', with: 'devise@devise.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    expect(page).to have_content('Email ou senha inválida.')
    expect(current_path).to eq(new_user_session_path)
  end
end
