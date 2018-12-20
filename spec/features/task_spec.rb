require 'rails_helper'

feature 'tasks index Sort' do
  scenario 'tasks sorts by create or update desc' do
    visit '/tasks'

    expected_tasks_order = Task.all
      .sort_by { |t| [t.created_at, t.updated_at].max }
      .reverse
      .map { |t| t.name }

    actual_tasks_order = page.body
      .scan(%r!<b>(.*?)</b>!) # ここにそれっぽいregexを書く
      .flatten

    expect(actual_tasks_order).to eq(expected_tasks_order)
  end
end

feature 'New Task' do
  scenario 'User create a new task' do
    visit '/tasks/new'

    fill_in 'task_name', :with => 'My Task'
    fill_in 'task_detail', :with => 'Detail'
    fill_in 'task_due_date', :with => ''

    click_button '保存'

    expect(page).to have_text 'タスクを作成しました'
  end

  scenario 'Empty task' do
    visit '/tasks/new'
    click_button '保存'
    expect(page).to have_text 'エラーが発生しました'
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
    fill_in 'task_due_date', :with => ''

    click_button '保存'

    expect(page).to have_text 'タスクを更新しました'
    expect(page).to have_text 'EditEdit'
    expect(page).to have_text 'detaildetaildetail'
  end

  scenario 'empty task' do
    visit tasks_show_path(Task.last.id)
    expect(page).to have_text 'MyString'

    click_link '編集'

    fill_in 'task_name', :with => ''
    fill_in 'task_detail', :with => ''

    click_button '保存'

    expect(page).to have_text 'エラーが発生しました'
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
