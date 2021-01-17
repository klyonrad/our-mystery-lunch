require 'rails_helper'

describe CreateMysteryLunch, '#select_lunch_partners' do
  subject(:result) do
    described_class.new(employees).select_lunch_partners
  end

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
end
