require 'rails_helper'

feature 'User delete periodicity' do
  scenario 'successfully' do
    user = create(:user)
    periodicity = create(:periodicity)

    sign_in user, scope: :user
    visit root_path
    click_link 'Periodicidades'
    within "tr#periodicity-#{periodicity.id}" do
      click_on 'deletar_button'
    end

    expect(page).to_not have_content('Mensal')
  end
end
