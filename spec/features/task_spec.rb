require 'rails_helper'

feature 'Task' do
  scenario 'Create a new task' do
    visit '/tasks/new'

    fill_in 'task_name', :with => 'My Task'
    fill_in 'task_detail', :with => 'Detail'

    click_button 'Save Task'

    expect(page).to have_text('タスクを作成しました')
  end
end
