class Tag < ActiveRecord::Base
	belongs_to :expense
	validates :tagname, :format => /^#\w+$|^#\w+([A-Za-z0-9-]*)\w$/
	validates_uniqueness_of :tagname, :scope =>:expense_id
	
	def self.search(search)
	@expenses = []
  if search  
  	search.split(" ").each do |key|
    	@tags = find(:all, :conditions => ['tagname LIKE ?', "%#{key}%"])
    	@tags.each do |tag|
    		flag = 0
    		@temp = Expense.find(tag.expense_id)
    		@expenses.each do |t|
    			if t == @temp    
    				flag = 1
    				break
    			end
    		end
    		if flag == 0
    			@expenses[@expenses.length] = Expense.find(tag.expense_id)
    		end
    	end
    end
  else
    #find(:all)
  end
  return @expenses
	end

end
		
