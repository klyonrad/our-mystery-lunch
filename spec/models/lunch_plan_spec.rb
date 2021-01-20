# frozen_string_literal: true

require 'rails_helper'

describe LunchPlan do
  describe '.lunches_in_month' do
    subject(:result) { described_class.lunches_in_month(year, month) }

    def year = 2020

    def month = 12

    context 'when no lunches are created yet' do
      it { is_expected.to be_empty }
    end

    context 'when one lunch exists for previous month and no lunch for the requested month exists' do
      before do
        create(:lunch, consumed_after: Date.new(year, month - 1))
      end

      it { is_expected.to be_empty }
    end

    context 'when one lunch exists for previous month and  one lunch for the requested month exists' do
      let!(:lunch_in_previous_month) { create(:lunch, consumed_after: Date.new(year, month - 1)) }
      let!(:lunch_in_current_month) { create(:lunch, consumed_after: Date.new(year, month)) }

      it 'contains the lunch in the requested month' do
        expect(result).to match_array([lunch_in_current_month])
      end
    end

    context 'when one lunch exists in the middle of the requested month' do
      let!(:lunch_in_current_month) { create(:lunch, consumed_after: Date.new(year, month, 15)) }

      it 'contains the lunch in the requested month' do
        expect(result).to match_array([lunch_in_current_month])
      end
    end

    context 'when one lunch exists for next month and  one lunch for the requested month exists' do
      let!(:lunch_in_month_after) { create(:lunch, consumed_after: Date.new(year, month).next_month) }
      let!(:lunch_in_current_month) { create(:lunch, consumed_after: Date.new(year, month)) }

      it 'contains the lunch in the requested month' do
        expect(result).to match_array([lunch_in_current_month])
      end
    end
  end

  describe '.exists_for_month?' do
    subject { described_class.exists_for_month?(year, month) }

    def year = 2020

    def month = 12

    context 'when no lunches are created yet' do
      it { is_expected.to be_falsey }
    end

    context 'when one lunch exists for previous month and no lunch for the requested month exists' do
      before do
        create(:lunch, consumed_after: Date.new(year, month - 1))
      end

      it { is_expected.to be_falsey }
    end

    context 'when one lunch exists for previous month and  one lunch for the requested month exists' do
      before do
        create(:lunch, consumed_after: Date.new(year, month - 1))
        create(:lunch, consumed_after: Date.new(year, month))
      end

      it { is_expected.to be_truthy }
    end

    context 'when one lunch exists in the middle of the requested month' do
      before do
        create(:lunch, consumed_after: Date.new(year, month, 15))
      end

      it { is_expected.to be_truthy }
    end
  end

  describe '.store_lunch_plan' do
    context 'when some employees exist' do
      let(:employees) do
        [create_list(:employee, 2), create_list(:employee, 2)]
      end

      it 'stores the given lunches into databases' do
        lunches = employees.map do |employee_tuple|
          build(:lunch,
                lunch_participations_attributes: [
                  { employee: employee_tuple.first },
                  { employee: employee_tuple.second }
                ])
        end
        result = described_class.store_lunch_plan(lunches)

        expect(result.all?(&:persisted?)).to be_truthy
        expect(Lunch.all.count).to eq(2)
      end

      it 'returns the saved lunches as array' do
        lunches = employees.map do |employee_tuple|
          build(:lunch,
                lunch_participations_attributes: [
                  { employee: employee_tuple.first },
                  { employee: employee_tuple.second }
                ])
        end
        result = described_class.store_lunch_plan(lunches)

        expect(result.flat_map(&:employees)).to match_array(employees.flatten)
      end
    end
  end
end
