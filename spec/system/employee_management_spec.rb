# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employee management', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  example 'user creates employee and sees it in the list and in the lunches' do
    lunch = create(:lunch, consumed_after: Time.current.beginning_of_month)
    2.times { create(:lunch_participation, lunch: lunch) }
    visit 'employees/new'
    expect(page).to have_content 'New Employee'

    fill_in 'Nick name', with: 'John Doe'
    select 'operations', from: 'Department'
    find('input[name="commit"]').click
    expect(page).to have_content 'Nick name: John Doe'

    click_on 'Back'
    expect(page).to have_content 'Show'
    expect(page).to have_content 'Edit'
    expect(page).to have_content 'Destroy'
    expect(page).to have_content 'John Doe'

    visit '/'
    expect(page).to have_content 'John Doe'
  end

  example 'user attempts creation with missing attributes' do
    visit 'employees/new'
    expect(page).to have_content 'New Employee'

    select 'sales', from: 'Department'
    find('input[name="commit"]').click
    expect(page).to have_content 'prohibited this employee from being saved'
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

  example 'user attempts invalid edit' do
    create(:employee, nick_name: 'John Doe', department: 'sales')
    visit employees_path
    expect(page).to have_content 'Edit'
    click_on 'Edit'

    expect(page).to have_content 'Editing Employee'
    fill_in 'Nick name', with: ''
    find('input[name="commit"]').click
    expect(page).to have_content 'prohibited this employee from being saved'
  end

  example 'user delets employee' do
    create(:employee, nick_name: 'John Doe', department: 'sales')
    visit employees_path
    expect(page).to have_content 'Destroy'
    accept_confirm 'Are you sure?' do
      click_on 'Destroy'
    end

    expect(page).to have_content 'Employee was successfully destroyed.'
    expect(page).not_to have_content 'John Doe'
  end

  context 'when fake employees and fake lunches are generated' do
    before do
      Employee.generate_fake
      LunchPlanHistoryGenerator.new.execute
    end

    it 'works' do
      visit 'employees'

      expect(page).to have_content 'Lunched with percentage'
    end
  end
end
