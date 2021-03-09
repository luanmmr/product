require 'rails_helper'

feature 'User Deactivate Plan' do
  let(:user) { create(:user) }

  scenario 'successfully' do
    plan = create(:plan, status: :disabled)

    sign_in user, scope: :user
    visit root_path
    click_on 'Planos'
    within "tr#plan-#{plan.id}" do
      click_link 'Ativar'
    end

    expect(page).to have_link('Desativar')
  end
end