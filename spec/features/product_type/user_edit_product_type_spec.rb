require 'rails_helper'

feature 'User edit product description' do
  scenario 'successfully' do
    user = create(:user)
    product = create(:product_type)

    sign_in user, scope: :user
    visit root_path
    click_link 'Produtos'
    within "tr#product-#{product.id}" do
      click_on 'Editar'
    end
    within 'form' do
      fill_in 'Descrição', with: 'Espaço para armazenamento do site'
      click_on 'Atualizar Produto'
    end

    expect(page).to have_content('Espaço para armazenamento do site')
    expect(page).to_not have_content('Meu teste testando')
  end

  scenario 'without entering the description' do
    user = create(:user)
    product = create(:product_type)

    sign_in user, scope: :user
    visit root_path
    click_link 'Produtos'
    within "tr#product-#{product.id}" do
      click_on 'Editar'
    end
    within 'form' do
      fill_in 'Descrição', with: ''
      click_on 'Atualizar Produto'
    end

    expect(page).to have_content('Descrição não pode ficar em branco')
  end

  scenario 'and name must be unique' do
    user = create(:user)
    product = create(:product_type)
    create(:product_type, name: 'Email')

    sign_in user, scope: :user
    visit root_path
    click_on 'Produtos'
    within "tr#product-#{product.id}" do
      click_on 'Editar'
    end
    within 'form' do
      fill_in 'Nome', with: 'Email'
      click_on 'Atualizar Produto'
    end

    expect(page).to have_content('Nome já está em uso')
  end
end
