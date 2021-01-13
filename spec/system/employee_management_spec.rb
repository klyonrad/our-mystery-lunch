# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employee management', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  example 'user creates employee and sees it in the list' do
    visit 'employees/new'
    expect(page).to have_content 'New Employee'

    fill_in 'Nick name', with: 'John Doe'
    find('input[name="commit"]').click
    expect(page).to have_content 'Nick name: John Doe'

    click_on 'Back'
    expect(page).to have_content 'Show'
    expect(page).to have_content 'Edit'
    expect(page).to have_content 'Destroy'
    expect(page).to have_content 'John Doe'
  end

  example 'user edits an existing employee in the list' do
    create(:employee, nick_name: 'John Doe', department: 'sales')
    visit employees_path
    expect(page).to have_content 'Edit'
    click_on 'Edit'

    expect(page).to have_content 'Editing Employee'
    fill_in 'Nick name', with: 'Maximiliane Musterfrau'
    find('input[name="commit"]').click
    expect(page).to have_content 'Nick name: Maximiliane Musterfrau'
  end
end
