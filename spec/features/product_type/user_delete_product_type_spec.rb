require 'rails_helper'

feature 'User delete product' do
  scenario 'successfully' do
    user = create(:user)
    product = create(:product_type)

    sign_in user, scope: :user
    visit root_path
    click_link 'Produtos'
    within "tr#product-#{product.id}" do
      click_on 'Deletar'
    end

    expect(page).to_not have_content('Hospedagem')
    expect(page).to_not have_content('Meu teste testando')
  end
end
