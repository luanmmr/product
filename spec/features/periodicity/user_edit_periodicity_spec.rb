require 'rails_helper'

feature 'User edit periodicity' do
  scenario 'successfully' do
    user = create(:user)
    periodicity = create(:periodicity)

    sign_in user, scope: :user
    visit root_path
    click_link 'Periodicidades'
    within "tr#periodicity-#{periodicity.id}" do
      click_on 'Editar'
    end
    within 'form' do
      fill_in 'Nome', with: 'trimestral'
      click_on 'Atualizar Periodicidade'
    end

    expect(page).to have_content('trimestral')
    expect(page).to have_content(3)
    expect(page).to_not have_content('mensal')
  end

  scenario 'with wrong name' do
    user = create(:user)
    periodicity = create(:periodicity)

    sign_in user, scope: :user
    visit root_path
    click_link 'Periodicidades'
    within "tr#periodicity-#{periodicity.id}" do
      click_on 'Editar'
    end
    within 'form' do
      fill_in 'Nome', with: 'teste'
      click_on 'Atualizar Periodicidade'
    end

    expect(page).to have_content('Nome não está incluído na lista')
  end

  scenario 'without entering the name' do
    user = create(:user)
    periodicity = create(:periodicity)

    sign_in user, scope: :user
    visit root_path
    click_link 'Periodicidades'
    within "tr#periodicity-#{periodicity.id}" do
      click_on 'Editar'
    end
    within 'form' do
      fill_in 'Nome', with: ''
      click_on 'Atualizar Periodicidade'
    end

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and must be unique' do
    user = create(:user)
    create(:periodicity, name: 'trimestral')
    periodicity = create(:periodicity)

    sign_in user, scope: :user
    visit root_path
    click_link 'Periodicidades'
    within "tr#periodicity-#{periodicity.id}" do
      click_on 'Editar'
    end
    within 'form' do
      fill_in 'Nome', with: 'trimestral'
      click_on 'Atualizar Periodicidade'
    end

    expect(page).to have_content('Nome já está em uso')
  end
end
