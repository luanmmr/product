require 'rails_helper'

feature 'User delete plan' do
  scenario 'successfully' do
    user = create(:user)
    plan = create(:plan)

    sign_in user, scope: :user
    visit root_path
    click_link 'Planos'
    within "tr#plan-#{plan.id}" do
      click_on 'deletar_button'
    end

    expect(page).to_not have_content('Go')
    expect(page).to_not have_content('Minha descrição')
  end
end
