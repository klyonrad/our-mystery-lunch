# frozen_string_literal: true

class CreateLunches < ActiveRecord::Migration[6.1]
  def change
    create_table :lunches do |t|
      t.datetime :consumed_after
    end
  end
end
