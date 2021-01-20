# frozen_string_literal: true

require 'rails_helper'

describe LunchPlanHistoryGenerator do
  # Integration test with a realistic amount of data
  it 'works' do
    Employee.generate_fake
    described_class.new.execute

    expect(Lunch.all.count).to eq(Employee.active.count / 2 * 6)

    # it is also idempotent (can be run twice without creating more lunches)
    described_class.new.execute

    expect(Lunch.all.count).to eq(Employee.active.count / 2 * 6)
  end
end
