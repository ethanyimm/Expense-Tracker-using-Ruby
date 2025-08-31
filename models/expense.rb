class Expense < ActiveRecord::Base
  validates :amount, presence: true, numericality: true
  validates :category, presence: true
end
