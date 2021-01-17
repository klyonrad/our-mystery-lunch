# frozen_string_literal: true

require 'rails_helper'

describe LunchPlan do
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
end
