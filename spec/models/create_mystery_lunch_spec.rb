# frozen_string_literal: true

require 'rails_helper'

describe CreateMysteryLunch, '#select_lunch_partners' do
  subject(:result) do
    described_class.new(employees, year: year, month: month).select_lunch_partners
  end
  def year = 2020

  def month = 12

  context 'given an even amount of employees' do
    let(:employees) do
      build_stubbed_list(:employee, 6)
    end

    it 'returns half the amount of lunches' do
      expect(result.map(&:class).uniq).to eq([Lunch])
      expect(result.size).to eq(3)
    end

    specify 'every employee is in exactly one lunch' do
      employees_from_result = result.flat_map(&:employees)

      expect(employees_from_result).to match_array(employees)
    end
  end

  context 'given an odd amount of employees' do
    let(:employees) do
      build_stubbed_list(:employee, 7)
    end

    it 'returns half the amount of lunches' do
      expect(result.map(&:class).uniq).to eq([Lunch])
      expect(result.size).to eq(3)
    end

    specify 'every employee is in exactly one lunch' do
      employees_from_result = result.flat_map(&:employees)

      expect(employees_from_result).to match_array(employees)
    end

    specify 'one lunch consists of three employees' do
      result_with_three_employees = result.select { |lunch| lunch.employees.size >= 3 }

      expect(result_with_three_employees.length).to eq(1)
    end
  end

  context 'given a year and a month' do
    let(:employees) do
      build_stubbed_list(:employee, 4)
    end

    specify 'all lunches start on first day of the given month' do
      start_dates_from_result = result.map(&:consumed_after)

      expect(start_dates_from_result.map(&:year).all? { |result_month| result_month == month })
      expect(start_dates_from_result.map(&:month).all? { |result_month| result_month == month })
      expect(start_dates_from_result.map(&:day).all? { |result_month| result_month == 1 })
    end
  end
end
