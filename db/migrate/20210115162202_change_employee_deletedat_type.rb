# frozen_string_literal: true

class ChangeEmployeeDeletedatType < ActiveRecord::Migration[6.1]
  def up
    change_column :employees, :deleted_at, :datetime, null: true
  end

  def down
    change_column :employees, :deleted_at, :time
  end
end
