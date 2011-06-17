class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.date :expense_date
      t.float :amount
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
