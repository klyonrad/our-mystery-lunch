# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employee management', type: :system do
  before do
    driven_by(:rack_test)
  end

  example 'user creates employee' do
    visit 'employees/new'
    expect(page).to have_content 'Create Employee'

    fill_in 'Nick name', with: 'John Doe'
    click_on 'Create Employee'
    expect(page).to have_content 'Nick name: John Doe'
  end
end
