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
end
