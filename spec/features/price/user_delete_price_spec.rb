require 'rails_helper'

feature 'User delete price' do
  scenario 'successfully' do
    user = create(:user)
    price = create(:price)

    sign_in user, scope: :user
    visit root_path
    click_link 'Preços'
    within "tr#price-#{price.id}" do
      click_on 'deletar_button'
    end

    expect(page).to_not have_content(59.90)
    expect(page).to_not have_content(price.id)
  end
end
