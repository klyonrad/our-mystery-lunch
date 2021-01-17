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
  end
end
