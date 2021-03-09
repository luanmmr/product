require 'rails_helper'

feature 'User register plan' do
  scenario 'successfully' do
    user = create(:user)
    create(:product_type)

    sign_in user, scope: :user
    visit root_path
    click_on 'Planos'
    click_on 'Add Plano'
    within 'form' do
      fill_in 'Nome', with: 'Go'
      fill_in 'Descrição', with: 'Minha descrição'
      select 'Hospedagem', from: 'Produto'
      fill_in 'Detalhes', with: 'Meus detalhes'
      choose 'Ativado'
      click_button 'Criar Plano'
    end

    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Go')
    expect(page).to have_content('Minha descrição')
    expect(page).to have_content('Meus detalhes')
    expect(page).to have_link('Desativar')
    expect(current_path).to eq(plans_path)
  end

  scenario 'without entering the datas' do
    user = create(:user)

    sign_in user, scope: :user
    visit root_path
    click_on 'Planos'
    click_on 'Add Plano'
    within 'form' do
      click_button 'Criar Plano'
    end

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Detalhes não pode ficar em branco')
    expect(page).to have_content('Status não pode ficar em branco')
  end

  scenario 'and must be unique' do
    user = create(:user)
    create(:plan)

    sign_in user, scope: :user
    visit root_path
    click_on 'Planos'
    click_on 'Add Plano'
    within 'form' do
      fill_in 'Nome', with: 'Go'
      click_button 'Criar Plano'
    end

    expect(page).to have_content('Nome já está em uso')
  end
end
