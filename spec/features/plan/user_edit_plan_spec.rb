require 'rails_helper'

feature 'User edit plan' do
  scenario 'successfully' do
    user = create(:user)
    plan = create(:plan)

    sign_in user, scope: :user
    visit root_path
    click_link 'Planos'
    within "tr#plan-#{plan.id}" do
      click_on 'Editar'
    end
    within 'form' do
      fill_in 'Nome', with: 'Hospedagem I'
      click_on 'Atualizar Plano'
    end

    expect(page).to have_content('Hospedagem i')
    expect(page).to have_content('Minha descrição')
    expect(page).to have_content('Meus detalhes')
    expect(page).to_not have_content('Go')
  end

  scenario 'without entering the datas' do
    user = create(:user)
    plan = create(:plan)

    sign_in user, scope: :user
    visit root_path
    click_link 'Planos'
    within "tr#plan-#{plan.id}" do
      click_on 'Editar'
    end
    within 'form' do
      fill_in 'Nome', with: ''
      fill_in 'Descrição', with: ''
      fill_in 'Detalhes', with: ''
      click_on 'Atualizar Plano'
    end

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Detalhes não pode ficar em branco')
  end

  scenario 'and name must be unique' do
    user = create(:user)
    product = create(:product_type, name: 'Email')
    plan_other = create(:plan, name: 'Initial', product_type: product)
    plan = create(:plan)

    sign_in user, scope: :user
    visit root_path
    click_on 'Planos'
    within "tr#plan-#{plan.id}" do
      click_on 'Editar'
    end
    within 'form' do
      fill_in 'Nome', with: 'Initial'
      click_on 'Atualizar Plano'
    end
    
    expect(page).to have_content('Nome já está em uso')
  end
end
