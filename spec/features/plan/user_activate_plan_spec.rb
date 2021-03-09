require 'rails_helper'

feature 'User Activate Plan' do
  let(:user) { create(:user) }

  scenario 'successfully' do
    plan = create(:plan)

    sign_in user, scope: :user
    visit root_path
    click_on 'Planos'
    within "tr#plan-#{plan.id}" do
      click_link 'Desativar'
    end

    expect(page).to have_link('Ativar')
  end
end