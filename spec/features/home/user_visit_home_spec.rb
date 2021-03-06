require 'rails_helper'

feature 'User visit home page' do
  scenario 'successfully' do
    user = create(:user)

    sign_in user, scope: :user
    visit root_path

    expect(page).to have_content('Página inicial')
    expect(current_path).to eq(root_path)
  end

  scenario 'and see your email in top bar' do
    user = create(:user)

    sign_in user, scope: :user
    visit root_path

    expect(page).to have_content('devise@devise.com.br')
  end

  scenario 'and does logout sucessfully' do
    user = create(:user)

    sign_in user, scope: :user
    visit root_path
    click_on 'Sair'

    expect(current_path).to eq(new_user_session_path)
  end
end
