class AddStartDateToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :start_date, :date
  end
end
