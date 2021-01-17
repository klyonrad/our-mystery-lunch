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
      new_lunch_couple = @remaining_partner_pool.sample(2)
      new_lunch = Lunch.new(
        lunch_participations_attributes: [
          { employee: new_lunch_couple.first },
          { employee: new_lunch_couple.second }
        ]
      )
      @lunches.append(new_lunch)
      @remaining_partner_pool.delete(new_lunch_couple.first)
      @remaining_partner_pool.delete(new_lunch_couple.second)
    end

    @lunches
  end
end
