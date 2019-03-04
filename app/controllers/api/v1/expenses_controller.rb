module Api
  module V1
    class ExpensesController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def index
        @expenses = Expense.all

        if params[:type_id].present?
          @expenses = @expenses.find_type_id(params[:type_id].to_i)
        end
        
        if params[:category_id].present?
          @expenses = @expenses.find_category_id(params[:category_id].to_i)
        end

        if params[:type].present?
          @expenses = @expenses.find_type(params[:type].to_s.capitalize)
        end
        
        if params[:category].present?
          @expenses = @expenses.find_category(params[:category].to_s.capitalize)
        end

        if params[:year].present?
          @expenses = @expenses.find_year(params[:year].to_i)
        end

        if params[:month].present?
          @expenses = @expenses.find_month(params[:month].to_i)
        end

        if params[:day].present?
          @expenses = @expenses.find_day(params[:day].to_i)
        end

        if params[:beginDate].present?
          @expenses = @expenses.find_by_begindate(params[:beginDate].to_date)
        end

        if params[:endDate].present?
          @expenses = @expenses.find_by_enddate(params[:endDate].to_date)
        end

        if params[:concept].present?
          @expenses = @expenses.find_by_concept(params[:concept].to_s)
        end

        if params[:page].present?
          @expenses = @expenses.paginate(:page => params[:page], :per_page => 10)
        end

        if params[:startAmount].present?
          @expenses = @expenses.find_by_startAmount(params[:startAmount].to_i)
        end

        if params[:endAmount].present?
          @expenses = @expenses.find_by_endAmount(params[:endAmount].to_i)
        end

        render json: @expenses
      end

      def create
        expense = Expense.new(safe_params)
        if expense.save
          render json: expense, status: 201
        else
          render json: { errors: expense.errors }, status: 422
        end
      end

      def update
        expense = Expense.find(params[:id])
        if expense.update(safe_params)
          render json: expense, status: 200
        else
          render json: {errors: expense.errors}, status: 422
        end
      end

      def destroy
        expense = Expense.find(params[:id])
        expense.destroy
        head :no_content
      end

      private
      def safe_params
        params.require(:expense).permit(:type_id, :date, :category_id, :concept, :amount)
      end
    end
  end
end
