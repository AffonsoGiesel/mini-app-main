require 'rails_helper'

feature 'Relatório deve ' do
  scenario 'mostrar todas as tasks de todos os usuários' do
    first_user = create(:user)
    second_user = create(:user)

    first_profile = create(:profile, user: first_user)
    second_profile = create(:profile, user: second_user)

    first_task = create(:task, user: first_user, id: 100000)

    login_as(second_user)

    visit root_path
    click_on 'Relatório de Tasks'

    expect(page).to have_css('td', text: first_task.id)
  end

  scenario 'mostrar todos os comentários de uma task' do
    first_user = create(:user)
    second_user = create(:user)

    first_profile = create(:profile, user: first_user)
    second_profile = create(:profile, user: second_user)

    first_task = create(:task, user: first_user)
    first_comment = create(:comment, user: first_user, task: first_task, body: "First Comment")
    second_comment = create(:comment, user: first_user, task: first_task, body: "Second Comment")
    third_comment = create(:comment, user: first_user, task: first_task, body: "Third Comment")

    login_as(second_user)

    visit root_path
    click_on 'Relatório de Tasks'

    expect(page).to have_content('Comments')
    expect(Comment.first.body).to eq 'First Comment'
    expect(Comment.second.body).to eq 'Second Comment'
    expect(Comment.third.body).to eq 'Third Comment'
  end

  scenario 'mostrar os comentários em ordem alfabética' do
    first_user = create(:user)
    second_user = create(:user)

    first_profile = create(:profile, user: first_user)
    second_profile = create(:profile, user: second_user)

    first_task = create(:task, user: first_user)
    first_comment = create(:comment, user: first_user, task: first_task, body: "B - First Comment")
    second_comment = create(:comment, user: first_user, task: first_task, body: "C - Second Comment")
    third_comment = create(:comment, user: first_user, task: first_task, body: "A -Third Comment")

    login_as(second_user)

    visit root_path
    click_on 'Relatório de Tasks'

    third_comment.body.should appear_before(first_comment.body)
    first_comment.body.should appear_before(second_comment.body)

  end

  scenario 'ter os campos Task (ID), Comments e Status' do
    first_user = create(:user)
    second_user = create(:user)

    first_profile = create(:profile, user: first_user)
    second_profile = create(:profile, user: second_user)

    first_task = create(:task, user: first_user, id: 100000)

    login_as(second_user)

    visit root_path
    click_on 'Relatório de Tasks'

    expect(page).to have_css('th', text: "Tasks(id)")
    expect(page).to have_css('th', text: "Comments")
    expect(page).to have_css('th', text: "Status")
  end


end
