class ExpensesController < ApplicationController
  # GET /expenses
  # GET /expenses.xml
  def index
    @expenses = Expense.find(:all, :order=>"expense_date")
    @expense = Expense.new

    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @expenses }
      format.js
    end
  end

  # GET /expenses/1
  # GET /expenses/1.xml
  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.xml
  def new
    @expense = Expense.new

    respond_to do |format|
      format.html # new.html.erb
      #format.xml  { render :xml => @expense }
      format.js
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
  end

	def editdate
    @expense = Expense.find(params[:id])
  end
  
  def editamount
    @expense = Expense.find(params[:id])
  end
  
  def editdescription
    @expense = Expense.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.xml
  def create
    @expense = Expense.new(params[:expense])
    @description = @expense.description
    @tags = parser(@description)
   	
    respond_to do |format|
      if @expense.save
      	@tags.each do |tag|
   				Tag.create(:tagname => tag, :expense_id => @expense.id)
   			end
        format.html { redirect_to(@expense, :notice => 'Expense was successfully created.') }
        #format.xml  { render :xml => @expense, :status => :created, :location => @expense }
        format.js
      else
        format.html { render :action => "new" }
        #format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
        format.js { render :action => "error" }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.xml
  def update
    @expense = Expense.find(params[:id])
    @original_tags = @expense.tags  

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
      	@modified_tags = parser(@expense.description)

    		#first delete no more exist original tags   			
    		@original_tags.each do |o|
    			flag1 = 0 
    			@modified_tags.each do |m|
    				if o.tagname == m
    					flag1 = 1	#this old tag still exists
    					break
    				end
    			end
    			if flag1 == 0
    				o.destroy
    			end
    		end
    		#then create new tags    			
 				@modified_tags.each do |m|
 					flag2 = 0
 					@original_tags.each do |o|
 						if m == o.tagname
 							flag2 = 1
 							break
 						end
 					end
 					if flag2 == 0
   					Tag.create(:tagname => m, :expense_id => params[:id])
   				end
   			end  		
        format.html { redirect_to(@expense, :notice => 'Expense was successfully updated.') }
        #format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        #format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
        format.js{ render :action => "error" }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.xml
  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    @tags = @expense.tags
    @tags.each do |tag|
    	tag.destroy
    end

    respond_to do |format|
      format.html { redirect_to(expenses_url) }
      #format.xml  { head :ok }
      format.js
    end
  end
  
  #parse out tags
  def parser(description)
		tags = [] #container for all tags in description
		pos = description.index('#')
		while !pos.nil?
		#if there exists at least one '#'
			#extract the tag
			newtag = "" #temp container for each tag
			#pos += 1
			while description[pos + newtag.length] != ' ' && pos + newtag.length < description.length
				newtag[newtag.length] = description[pos + newtag.length]
			end
			tags[tags.length] = newtag
			#get rid of the extracted tag and prepare to parse for the rest text
			description = description[pos + newtag.length+1 .. description.length]
			#if pos_newtag.length+1 == description.length, description is ""
			#if pos_newtag.length+! > description.length, description is nil
			if description.nil? || description.length == 0 #all text has been parsed
				break
			elsif description.length > 0
				pos = description.index('#')
			end
		end
		return tags
	end

  def balancechart
  	@expense_months = Expense.all.group_by{|t| t.expense_date.end_of_month}
  	respond_to do |format|
      format.html 
      #format.xml  { render :xml => @expense }
    end
	end
end
