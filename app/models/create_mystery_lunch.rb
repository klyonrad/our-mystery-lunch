# frozen_string_literal: true

class CreateMysteryLunch
  def initialize(employees, year: Time.current.year, month: Time.current.month,
                 lunch_repo: LunchPlan, partner_pool: PartnerPool)
    @given_employees = employees
    @year = year
    @month = month
    @lunch_repo = lunch_repo
    @remaining_partner_pool = partner_pool.new(@given_employees)
    @lunches = []
  end

  # @return [Lunch]
  def make_new_lunch_plan
    select_lunch_partners
    @lunch_repo.store_lunch_plan(@lunches)
  end

  def select_lunch_partners
    while @remaining_partner_pool.any?
      @lunches.append(
        lunch_for_employees(@remaining_partner_pool.grab_partners)
      )
    end

    @lunches
  end

  private

  # @param [Employee] new_lunch_participants
  def lunch_for_employees(new_lunch_participants)
    lunch_participations = new_lunch_participants.map do |employee|
      { employee: employee }
    end
    Lunch.new(
      consumed_after: Date.new(@year, @month, 1),
      lunch_participations_attributes: lunch_participations
    )
  end
end
