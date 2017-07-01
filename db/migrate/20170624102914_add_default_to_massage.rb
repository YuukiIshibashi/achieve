class AddDefaultToMassage < ActiveRecord::Migration
  def change
    change_column_default :messages, :read, 'false'
  end
end
