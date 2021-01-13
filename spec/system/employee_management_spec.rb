# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employee management', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  example 'user creates employee' do
    visit 'employees/new'
    expect(page).to have_content 'New Employee'

    fill_in 'Nick name', with: 'John Doe'
    find('input[name="commit"]').click
    expect(page).to have_content 'Nick name: John Doe'
  end
end
