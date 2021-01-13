# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :nick_name
      t.string :department
      t.time :deleted_at

      t.timestamps
    end
  end
end
