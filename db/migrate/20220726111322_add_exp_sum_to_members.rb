class AddExpSumToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :exp_sum, :integer,null: false, default: 0
  end
end
