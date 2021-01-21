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
    @grabbed_partners << potential_partners_not_met_recently.sample
    if @remaining_partner_pool.length.odd?
      # When making three people lunch it is not required that the third person did not met the others recently
      @grabbed_partners << potential_partners.sample
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

  def potential_partners_not_met_recently
    potential_partners.reject do |employee|
      @grabbed_partners.first.lunched_with_recently?(employee)
    end
  end

  def potential_partners
    @remaining_partner_pool.reject do |employee|
      employee.department.in?(@grabbed_partners.map(&:department))
    end
  end

  def reduce_remaining_pool
    @grabbed_partners.each { |employee| @remaining_partner_pool.delete(employee) }
  end
end
