# frozen_string_literal: true

require 'rails_helper'

describe PartnerPool do
  describe '#grab_partners' do
    let(:subject) { described_class.new(employees) }
    def subject_call = subject.grab_partners

    context 'given 24 employees from six departments' do
      let(:employees) do
        %w[HR risk management sales development data].map do |department|
          build_stubbed_list(:employee, 4, department: department)
        end.flatten
      end

      it 'returns all the employees exactly once with half the amount of calls' do
        result = []
        (employees.length / 2).times do
          result << subject_call
        end

        expect(result.flatten).to match_array(employees)
      end
    end

    context 'given 35 employees from five departments' do
      let(:employees) do
        %w[HR risk management sales data].map do |department|
          build_stubbed_list(:employee, 7, department: department)
        end.flatten
      end

      it 'returns all the employees exactly once with half the amount of calls' do
        result = []
        (employees.length / 2).times do
          result << subject_call
        end

        expect(result.flatten).to match_array(employees)
      end

      specify 'one lunch should have size of three' do
        result = []
        (employees.length / 2).times do
          result << subject_call
        end

        assert(result.one? { |partners| partners.length == 3 })
      end
    end
  end
end
