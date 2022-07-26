class AddLevelToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :level, :integer,null: false, default: 1
  end
end
