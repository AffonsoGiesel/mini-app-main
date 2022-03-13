require 'rails_helper'

feature 'User can Create Task' do
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

    expect(page).to have_content('Task Created!')
    expect(Task.last.title).to eq 'Test Task'
    expect(Task.last.description).to eq 'Test Description'
    expect(Task.last.priority).to eq 'Medium'
    expect(Task.last.share).to eq false
  end

  scenario 'And must be logged in' do
    user = create(:user)
    profile = create(:profile, user: user)

    visit new_task_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'And Title must have more than 4 characters' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)
    visit root_path
    click_on 'Create a Task'
    fill_in 'Task Title', with: Faker::Lorem.characters(number: 3)
    fill_in 'Description', with: 'Test Description'
    select 'Medium', from: 'Priority'
    select 'Private', from: 'Privacy'
    click_on 'Create Task'

    expect(page).to have_content("Title is too short (minimum is 4 characters)")
  end

  scenario 'And Title must have less than 20 characters' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)
    visit root_path
    click_on 'Create a Task'
    fill_in 'Task Title', with: Faker::Lorem.characters(number: 21)
    fill_in 'Description', with: 'Test Description'
    select 'Medium', from: 'Priority'
    select 'Private', from: 'Privacy'
    click_on 'Create Task'

    expect(page).to have_content("Title is too long (maximum is 20 characters)")
  end 

  scenario 'And Description Can\'t be blank' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)
    visit root_path
    click_on 'Create a Task'
    fill_in 'Task Title', with: 'Test Task'
    fill_in 'Description', with: ''
    select 'Medium', from: 'Priority'
    select 'Private', from: 'Privacy'
    click_on 'Create Task'

    expect(page).to have_content("Description can't be blank")
  end
end

