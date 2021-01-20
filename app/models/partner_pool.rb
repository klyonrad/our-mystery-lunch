# frozen_string_literal: true

class PartnerPool
  def initialize(employees)
    @remaining_partner_pool = employees.shuffle # increase randomness and leave given employees untouched
  end

  # @return [Object]
  def grab_partners
    @grabbed_partners = @remaining_partner_pool.sample(partner_amount)
    reduce_remaining_pool
    @grabbed_partners
  end

  def any?
    @remaining_partner_pool.any?
  end

  private

  def reduce_remaining_pool
    @grabbed_partners.each { |employee| @remaining_partner_pool.delete(employee) }
  end

  def partner_amount
    if @remaining_partner_pool.size == 3
      3
    else
      2
    end
  end
end
