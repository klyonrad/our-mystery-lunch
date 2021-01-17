# frozen_string_literal: true

# Serves as repository
class LunchPlan
  def self.exists_for_month?(year, month)
    Lunch.where(consumed_after: Date.new(year, month)..).any?
  end

  # def lunches_in_month(year, month)
end
