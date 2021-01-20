# frozen_string_literal: true

require 'rails_helper'

describe CreateMysteryLunch, '#select_lunch_partners' do
  subject(:result) do
    described_class.new(employees, year: year, month: month, partner_pool: pool_repo).select_lunch_partners
  end
  def year = 2020

  def month = 12

  context 'when partner pool returns any? with true twice' do
    let(:pool_repo) do
      pool_object = instance_double('PartnerPool')
      allow(pool_object).to receive(:any?)
        .and_return(true, true, false)
      expect(pool_object).to receive(:grab_partners)
        .and_return(first_lunch_partners, second_lunch_partners)
      class_double('PartnerPool', new: pool_object)
    end

    let(:first_lunch_partners) { build_stubbed_list(:employee, 2) }
    let(:second_lunch_partners) { build_stubbed_list(:employee, 2) }

    let(:employees) { first_lunch_partners + second_lunch_partners }

    it 'returns two lunches' do
      expect(result.map(&:class).uniq).to eq([Lunch])
      expect(result.size).to eq(2)
    end

    it 'returns all the given employees' do
      employees_from_result = result.flat_map(&:employees)

      expect(employees_from_result).to match_array(employees)
    end

    context 'given a year and a month' do
      specify 'all lunches start on first day of the given month' do
        start_dates_from_result = result.map(&:consumed_after)

        expect(start_dates_from_result.map(&:year).all? { |result_month| result_month == month })
        expect(start_dates_from_result.map(&:month).all? { |result_month| result_month == month })
        expect(start_dates_from_result.map(&:day).all? { |result_month| result_month == 1 })
      end
    end
  end
end

describe CreateMysteryLunch, '#make_new_lunch_plan' do
  subject(:result) do
    described_class.new(employees, lunch_repo: lunch_repo, partner_pool: pool_repo).make_new_lunch_plan
  end

  let(:employees) do
    build_stubbed_list(:employee, 6)
  end
  let(:lunch_repo) do
    class_double('LunchPlan')
  end
  let(:pool_repo) do
    pool_object = instance_double('PartnerPool')
    allow(pool_object).to receive(:grab_partners)
      .and_return(build_list(:employee, 2), build_list(:employee, 2))
    allow(pool_object).to receive(:any?)
      .and_return(true, true, false)
    class_double('PartnerPool', new: pool_object)
  end

  it 'calls the persist method of given repo' do
    expect(lunch_repo).to receive(:store_lunch_plan)

    result
  end
end
