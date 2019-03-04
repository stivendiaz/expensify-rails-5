class ExpensesController < ApplicationController
  respond_to :html, :js

  def index
    @tab = :expenses
    @categories = Category.all
    @types = Type.all
    @months = generate_last_n_months (12)

    @current_month = @months[params[:date].to_i]

    month = @current_month.month
    year = @current_month.year

    @expenses = Expense.find_year(year).find_month(month).order(date: :desc)

    if params[:type_id].present?
      @expenses = @expenses.find_type_id(params[:type_id].to_i)
    end
    
    if params[:category_id].present?
      @expenses = @expenses.find_category_id(params[:category_id].to_i)
    end

    respond_to do |format|
      format.js
      format.html {render 'index'}
    end

  end

  def new
    @expense = Expense.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    puts params[:date]
    @categories = Category.all
    @types = Type.all
    @expense = Expense.new safe_params
    @alert_msg = ''
    if @expense.save
      @alert_msg = 'Expense successfully created'
    else
      render :new
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  def edit
    @expense = Expense.find params[:id]
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    @categories = Category.all
    @types = Type.all
    @alert_msg = ''
    @expense = Expense.find params[:id]
    @old_amount = @expense.amount
    if @expense.update safe_params
      @alert_msg = 'Expense successfully updated'
    else
      render :edit
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  def destroy
    @alert_msg = ''
    @expense = Expense.find params[:id]
    @expense.destroy
    @alert_msg = 'Expense successfully deleted'
  end

  protected

  def safe_params
    params.require(:expense).permit(:type_id, :date, :category_id, :concept, :amount)
  end

end
