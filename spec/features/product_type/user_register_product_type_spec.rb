require 'rails_helper'

feature 'User register product' do
  scenario 'successfully' do
    user = create(:user)

    sign_in user, scope: :user
    visit root_path
    click_on 'Produtos'
    click_on 'Add Produto'
    within 'form' do
      fill_in 'Nome', with: 'hospedagem de sites'
      fill_in 'Descrição', with: 'Espaço para armazenamento do site'
      click_button 'Criar Produto'
    end

    expect(page).to have_content('Hospedagem de sites')
    expect(page).to have_content('Espaço para armazenamento do site')
    expect(current_path).to eq(product_types_path)
  end

  scenario 'without entering the name and describe' do
    user = create(:user)

    sign_in user, scope: :user
    visit root_path
    click_on 'Produtos'
    click_on 'Add Produto'
    within 'form' do
      fill_in 'Nome', with: ''
      fill_in 'Descrição', with: ''
      click_button 'Criar Produto'
    end

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
  end

  scenario 'and must be unique' do
    user = create(:user)
    create(:product_type)

    sign_in user, scope: :user
    visit root_path
    click_on 'Produtos'
    click_on 'Add Produto'
    within 'form' do
      fill_in 'Nome', with: 'Hospedagem'
      fill_in 'Descrição', with: 'Espaço para armazenamento do site'
      click_button 'Criar Produto'
    end

    expect(page).to have_content('Nome já está em uso')
  end
end
