require 'rails_helper'

feature 'User register periodicity' do
  scenario 'successfully' do
    user = create(:user)

    sign_in user, scope: :user
    visit root_path
    click_on 'Periodicidades'
    click_on 'Add Periodicidade'
    within 'form' do
      fill_in 'Nome', with: 'mensal'
      click_button 'Criar Periodicidade'
    end

    expect(page).to have_content('Mensal')
    expect(page).to have_content('1')
    expect(current_path).to eq(periodicities_path)
  end

  scenario 'with wrong name' do
    user = create(:user)

    sign_in user, scope: :user
    visit root_path
    click_on 'Periodicidades'
    click_on 'Add Periodicidade'
    within 'form' do
      fill_in 'Nome', with: 'teste'
      click_button 'Criar Periodicidade'
    end

    expect(page).to_not have_content('teste')
    expect(page).to have_content('Não foi possível adicionar periodicidade')
    expect(page).to have_content('Nome não está incluído na lista')
  end

  scenario 'without entering the name' do
    user = create(:user)

    sign_in user, scope: :user
    visit root_path
    click_on 'Periodicidades'
    click_on 'Add Periodicidade'
    within 'form' do
      fill_in 'Nome', with: ''
      click_button 'Criar Periodicidade'
    end

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and must be unique' do
    user = create(:user)
    create(:periodicity)

    sign_in user, scope: :user
    visit root_path
    click_on 'Periodicidades'
    click_on 'Add Periodicidade'
    within 'form' do
      fill_in 'Nome', with: 'mensal'
      click_button 'Criar Periodicidade'
    end

    expect(page).to have_content('Nome já está em uso')
  end
end
