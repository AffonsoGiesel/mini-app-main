require 'rails_helper'

feature 'User can edit Tasks' do
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

    click_on 'Edit Task'

    fill_in 'Task Title', with: 'Test Task Edited'
    fill_in 'Description', with: 'Test Description Edited'
    select 'High', from: 'Priority'
    select 'Public', from: 'Privacy'
    click_on 'Update Task'

    expect(page).to have_content('Task Updated!')
    expect(Task.last.title).to eq 'Test Task Edited'
    expect(Task.last.description).to eq 'Test Description Edited'
    expect(Task.last.priority).to eq 'High'
    expect(Task.last.share).to eq true
  end 

  scenario 'And must fill all fields' do
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

    click_on 'Edit Task'

    fill_in 'Task Title', with: ''
    fill_in 'Description', with: ''
    select 'High', from: 'Priority'
    select 'Public', from: 'Privacy'
    click_on 'Update Task'

    expect(page).to have_content('Title is too short (minimum is 4 characters)')
    expect(page).to have_content("Description can't be blank")

  end
end
