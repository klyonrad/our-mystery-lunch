# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home Page', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  describe 'GET /' do
    it 'returns http success' do
      create_list(:employee, 5, department: 'HR')
      create_list(:employee, 5, department: 'risk')
      visit '/'

      expect(page).to have_content 'This is the current mystery lunch plan'
      expect(page).to have_content '(HR)'
    end
  end
end
