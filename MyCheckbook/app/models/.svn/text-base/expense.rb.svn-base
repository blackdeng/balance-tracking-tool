class Expense < ActiveRecord::Base
	has_many :tags
	validates :expense_date, :presence => true
	validates :amount, :presence => true
	validates_numericality_of :amount
	validates :description, :presence => true
end
