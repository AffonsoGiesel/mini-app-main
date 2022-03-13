require 'rails_helper'

feature 'User can Delete Tasks' do
  scenario 'Successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)
    visit root_path
    click_on 'Create a Task'
    fill_in 'Task Title', with: 'Test Task'
    fill_in 'Description', with: 'Test Description'
    select 'Medium', from: 'Priority'
    select 'Private', from: 'Privacy'
    click_on 'Create Task'

    click_on 'Go Back'

    find('#botao_apagar').click
    expect(page).to have_content('Task apagada!')
  end

  scenario 'And Must be logged in' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)
    visit root_path
    click_on 'Create a Task'
    fill_in 'Task Title', with: 'Test Task'
    fill_in 'Description', with: 'Test Description'
    select 'Medium', from: 'Priority'
    select 'Private', from: 'Privacy'
    click_on 'Create Task'

    click_on 'Go Back'
    click_on 'Log Out'
    visit tasks_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
   end
end
