class AddAgeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ddabong_count, :integer, default: 0
  end
end
