# frozen_string_literal: true

require 'rails_helper'

describe CurrentLunchPlan do
  context 'when lunches already exist for current month' do
    let(:lunch_repo) do
      class_double('LunchPlan', exists_for_month?: true)
    end
    let(:random_lunch_generator_klass) do
      double('CreateMysteryLunch', new: random_lunch_generator)
    end
    let(:random_lunch_generator) do
      instance_double('CreateMysteryLunch')
    end

    it 'does not call the random lunch generator' do
      expect(random_lunch_generator).not_to receive(:make_new_lunch_plan)
      current_lunch_plan =
        described_class.new(lunch_repo: lunch_repo, random_lunch_generator: random_lunch_generator_klass)

      current_lunch_plan.view_or_create
    end
  end

  context 'when lunches do not exist yet for this month' do
    let(:lunch_repo) do
      class_double('LunchPlan', exists_for_month?: false)
    end
    let(:random_lunch_generator_klass) do
      double('CreateMysteryLunch', new: random_lunch_generator)
    end
    let(:random_lunch_generator) do
      instance_double('CreateMysteryLunch')
    end

    it 'calls the random lunch generator' do
      expect(random_lunch_generator).to receive(:make_new_lunch_plan)
      current_lunch_plan =
        described_class.new(lunch_repo: lunch_repo, random_lunch_generator: random_lunch_generator_klass)

      current_lunch_plan.view_or_create
    end
  end
end
