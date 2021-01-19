# frozen_string_literal: true

class CreateMysteryLunch
  def initialize(employees, year: Time.current.year, month: Time.current.month)
    @given_employees = employees
    @year = year
    @month = month
    @remaining_partner_pool = @given_employees.shuffle # increase randomness and leaven given employees untouched
    @lunches = []
  end

  def select_lunch_partners
    while @remaining_partner_pool.any?
      amount_of_lunch_participants =
        if @remaining_partner_pool.size == 3
          3
        else
          2
        end
      new_lunch_participants = @remaining_partner_pool.sample(amount_of_lunch_participants)
      @lunches.append(lunch_for_employees(new_lunch_participants))
      new_lunch_participants.each do |employee|
        @remaining_partner_pool.delete(employee)
      end
    end

    @lunches
  end

  private

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
