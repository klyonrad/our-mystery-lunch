# frozen_string_literal: true

# Serves as repository
class LunchPlan
  def self.lunches_in_month(year, month)
    Lunch.includes(lunch_participations: :employee).where(consumed_after: Date.new(year, month)..)
  end

  def self.exists_for_month?(year, month)
    Lunch.where(consumed_after: Date.new(year, month)..).any?
  end

  # @param [Lunch] lunches - In memory lunch objects, hopefully with their participants :)
  def self.store_lunch_plan(lunches)
    Lunch.transaction do
      lunches.each(&:save!)
    end
  end
end
