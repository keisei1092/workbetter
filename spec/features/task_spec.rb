require 'rails_helper'

feature 'New Task' do
  scenario 'User create a new task' do
    visit '/tasks/new'

    fill_in 'task_name', :with => 'My Task'
    fill_in 'task_detail', :with => 'Detail'

    click_button '保存'

    expect(page).to have_text 'タスクを作成しました'
  end
end

feature 'Edit Task' do
  fixtures :tasks

  scenario 'User edits task' do
    visit tasks_show_path(Task.last.id)
    expect(page).to have_text 'MyString'

    click_link '編集'

    fill_in 'task_name', :with => 'EditEdit'
    fill_in 'task_detail', :with => 'detaildetaildetail'

    click_button '保存'

    expect(page).to have_text 'タスクを更新しました'
    expect(page).to have_text 'EditEdit'
    expect(page).to have_text 'detaildetaildetail'
  end
end

feature 'Delete Task' do
  fixtures :tasks

  scenario 'User deletes task' do
    visit tasks_show_path(Task.last.id)
    expect(page).to have_text 'MyString'

    click_link '削除'

    expect(page).to have_text 'タスクを削除しました'
    expect(page).not_to have_text 'MyString'
    expect(page).not_to have_text 'MyText'
  end
end
