# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe '.active' do
    subject { described_class.active }

    context 'given one employee with deleted_at and one without' do
      before do
        @active_employee = create(:employee, deleted_at: nil)
        @inactive_employee = create(:employee, deleted_at: Time.current)
      end

      it { is_expected.not_to include(@inactive_employee) }
      it { is_expected.to include(@active_employee) }
    end
  end

  describe '#lunched_with_recently?' do
    subject { employee.lunched_with_recently?(other_employee) }
    let(:employee) do
      create(:employee)
    end
    let(:other_employee) do
      create(:employee)
    end

    context 'when they participated with other employee in the three months ago' do
      before do
        date = Date.current.months_ago(3)
        lunch = create(:lunch, consumed_after: date)
        create(:lunch_participation, employee: employee, lunch: lunch)
        create(:lunch_participation, employee: other_employee, lunch: lunch)
      end

      it { is_expected.to be_truthy }
    end

    context 'when they participated with other employee four months ago' do
      before do
        date = Date.current.months_ago(4)
        lunch = create(:lunch, consumed_after: date)
        create(:lunch_participation, employee: employee, lunch: lunch)
        create(:lunch_participation, employee: other_employee, lunch: lunch)
      end

      it { is_expected.to be_falsey }
    end

    context 'when they participated with other employees than other_employee' do
      before do
        date = Date.current.months_ago(2)
        lunch = create(:lunch, consumed_after: date)
        create(:lunch_participation, employee: employee, lunch: lunch)
        create(:lunch_participation, employee: create(:employee), lunch: lunch)
      end

      it { is_expected.to be_falsey }
    end
  end
end
