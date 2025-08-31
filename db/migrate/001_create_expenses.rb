class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string  :category
      t.decimal :amount, precision: 10, scale: 2
      t.date    :date
      t.string  :description
      t.timestamps
    end
  end
end