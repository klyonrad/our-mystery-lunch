# frozen_string_literal: true

require 'rails_helper'

describe EmployeeTermination do
  describe '#execute' do
    specify 'deleted_at attribute is set and stored for a given active employee' do
      active_employee = create(:employee, deleted_at: nil)
      object_instance = described_class.new(active_employee)
      object_instance.execute
      active_employee.reload

      expect(active_employee.deleted_at).to be_today # this works as long as test does run around midnight ;)
    end

    context 'when a lunch plan exists for the current month' do
      subject { described_class.new(deleted_employee.reload) }

      context 'when employee is in a 3 people mystery lunch' do
        let(:deleted_employee) { create(:employee) }
        let(:lunch) do
          create(:lunch, consumed_after: Time.current.beginning_of_month)
        end

        before do
          create(:lunch_participation, employee: deleted_employee, lunch: lunch)
          create_list(:lunch_participation, 2, lunch: lunch)
        end

        it 'removes them from that lunch and otherwise stays the same' do
          lunchees_without_employee = lunch.employees.reject { |lunchees| lunchees == deleted_employee }
          subject.execute

          expect(lunch.reload.employees).to match_array(lunchees_without_employee)
        end
      end

      context 'when employee has one lunch partner and other lunches exist' do
        let(:deleted_employee) { create(:employee) }
        let(:remaining_employee_in_affected_lunch) { create(:employee) }
        let(:lunch) do
          create(:lunch, consumed_after: Time.current.beginning_of_month)
        end
        let!(:other_lunch) { create(:lunch, :with_two_participants) }

        before do
          create(:lunch_participation, employee: deleted_employee, lunch: lunch)
          create(:lunch_participation, lunch: lunch, employee: remaining_employee_in_affected_lunch)
        end

        it 'removes them from the lunch and the partner comes to a random lunch' do
          subject.execute

          expect(other_lunch.reload.employees.size).to eq(3)
          expect(other_lunch.employees).to include(remaining_employee_in_affected_lunch)
        end
      end
    end
  end
end
