# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @lunch_plan = CurrentLunchPlan.new.view_or_create
    @past_lunches = LunchPlan.past_lunches
  end
end
