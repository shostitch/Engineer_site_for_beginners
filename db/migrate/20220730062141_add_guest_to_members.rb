class AddGuestToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :guest, :boolean,default: false,null: false
  end
end
