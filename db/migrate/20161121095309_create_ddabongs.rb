class CreateDdabongs < ActiveRecord::Migration[5.0]
  def change
    create_table :ddabongs do |t|
      t.integer :from
      t.integer :to
    end
  end
end
