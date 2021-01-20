# frozen_string_literal: true

class PartnerPool
  # @param [Employee] employees
  def initialize(employees)
    @remaining_partner_pool = employees.shuffle # increase randomness and leave given employees untouched
  end

  # @return [Object]
  def grab_partners
    @grabbed_partners = []
    @grabbed_partners << @remaining_partner_pool.sample
    (partner_amount - 1).times do
      @grabbed_partners << potential_partners.sample
    end

    reduce_remaining_pool
    @grabbed_partners
  end

  def any?
    @remaining_partner_pool.any?
  end

  private

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
