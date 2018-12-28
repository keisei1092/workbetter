require 'rails_helper'

feature 'tasks index' do
  fixtures :tasks

  before(:each) do
    visit '/tasks'
  end

  scenario 'task search by keyword' do
    fill_in 'q', with: 'MyString'
    click_button '検索'
    expect(page).to have_text 'MyString'
  end

  scenario 'task search by status' do
    find("option[value='done']").select_option
    click_button '検索'
    expect(page).to have_text 'ThreeTask'
  end

  scenario 'task search by keyword and status' do
    # do something
  end

  scenario 'tasks sort by create or update desc' do
    expected_tasks_order = Task.all
      .sort_by { |t| [t.created_at, t.updated_at].max }
      .reverse
      .map { |t| t.name }

    actual_tasks_order = page.body
      .scan(%r!<b>(.*?)</b>!)
      .flatten

    expect(actual_tasks_order).to eq(expected_tasks_order)
  end

  scenario 'tasks sort by due_date' do
    click_link('終了期限')

    expected_tasks_order = Task.all
      .sort_by { |t| t.due_date }
      .reverse
      .map { |t| t.name }

    actual_tasks_order = page.body
      .scan(%r!<b>(.*?)</b>!)
      .flatten

    expect(actual_tasks_order).to eq(expected_tasks_order)
  end
end

feature 'New Task' do
  before(:each) do
    visit '/tasks/new'
  end

  scenario 'User create a new task' do
    fill_in 'task_name', with: 'My Task'
    fill_in 'task_detail', with: 'Detail'
    fill_in 'task_due_date', with: ''

    click_button '保存'

    expect(page).to have_text 'タスクを作成しました'
  end

  scenario 'Empty task' do
    click_button '保存'
    expect(page).to have_text 'エラーが発生しました'
  end

  scenario 'invalid due date' do
    fill_in 'task_name', with: 'My Task'
    fill_in 'task_detail', with: 'Detail'
    fill_in 'task_due_date', with: DateTime.now - 1

    click_button '保存'

    expect(page).to have_text 'エラーが発生しました'
  end
end

feature 'Edit Task' do
  fixtures :tasks

  before(:each) do
    visit tasks_show_path(Task.last.id)
  end

  scenario 'User edits task' do
    click_link '編集'

    fill_in 'task_name', with: 'EditEdit'
    fill_in 'task_detail', with: 'detaildetaildetail'
    fill_in 'task_due_date', with: ''

    click_button '保存'

    expect(page).to have_text 'タスクを更新しました'
    expect(page).to have_text 'EditEdit'
    expect(page).to have_text 'detaildetaildetail'
  end

  scenario 'empty task' do
    click_link '編集'

    fill_in 'task_name', with: ''
    fill_in 'task_detail', with: ''

    click_button '保存'

    expect(page).to have_text 'エラーが発生しました'
  end
end

feature 'Delete Task' do
  fixtures :tasks

  before(:each) do
    visit tasks_show_path(Task.last.id)
  end

  scenario 'User deletes task' do
    click_link '削除'

    expect(page).to have_text 'タスクを削除しました'
    expect(page).not_to have_text 'MyString'
    expect(page).not_to have_text 'MyText'
  end
end
