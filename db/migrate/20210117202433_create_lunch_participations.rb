# frozen_string_literal: true

class CreateLunchParticipations < ActiveRecord::Migration[6.1]
  def change
    create_table :lunch_participations do |t|
      t.references :lunch, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
