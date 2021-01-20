# frozen_string_literal: true

class PartnerPool
  # @param [Employee] employees
  def initialize(employees)
    @remaining_partner_pool = employees.shuffle # increase randomness and leave given employees untouched
  end

  # @return [Object]
  def grab_partners
    @grabbed_partners = []
    # Sampling someone from most frequent department first reduces the chance
    # of exhausting the randomness.
    @grabbed_partners << from_most_frequent_department.sample
    (partner_amount - 1).times do
      new_partner = potential_partners.sample

      @grabbed_partners << new_partner
    end

    reduce_remaining_pool
    @grabbed_partners
  end

  def any?
    @remaining_partner_pool.any?
  end

  private

  def from_most_frequent_department
    @remaining_partner_pool.select { |employee| employee.department == most_frequent_department }
  end

  def most_frequent_department
    @remaining_partner_pool.map(&:department).tally.min_by { |_key, value| -value }.first
  end

  def potential_partners
    @remaining_partner_pool.reject do |employee|
      employee.department.in?(@grabbed_partners.map(&:department))
    end
  end

  def reduce_remaining_pool
    @grabbed_partners.each { |employee| @remaining_partner_pool.delete(employee) }
  end

  def partner_amount
    if @remaining_partner_pool.length.odd?
      3
    else
      2
    end
  end
end
