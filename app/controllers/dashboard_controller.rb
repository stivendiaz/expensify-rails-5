class DashboardController < ApplicationController
  def index
    @tab = :dashboard
    last_6_months = generate_last_n_months (6)
    last_6_months_expenses = Expense.last_6_months # única petición a la base de datos
    @actual_month_amount = 0
    @last_month_amount = 0
    date_tree = {}
    month_totals = {}

    type_quantity = Type.count

    # graph-1

    @options_1 = {
      animationEnabled: true,
      backgroundColor: '#303336',
      title:{
        text: "Last 6 months"
      },
      axisX: {
        interval: 1,
        # intervalType: "month"
      },
      axisY: {
        prefix: "$"
      },
      data: []
    }

    last_6_months.each do |m|
      date_tree[m.strftime('%b-%Y')] = last_6_months_expenses.find_all {|ex| ex.date.month == m.month }
      month_totals[m.strftime('%b-%Y')] = {}
      type_quantity.times do |i|
        month_totals[m.strftime('%b-%Y')][i+1] = 0
      end
    end

    6.times do |i|
      date_tree[last_6_months[i].strftime('%b-%Y')].each do |element|
        month_totals[last_6_months[i].strftime('%b-%Y')][element.type_id] += element.amount
        if i == 0
          @actual_month_amount += element.amount
        end
        if i == 1
          @last_month_amount += element.amount
        end
      end
    end

    type_quantity.times do |i|
      data_helper =  {
        type: "column",
        name: "#{Type.where('id = ?', i+1)[0].name}",
        showInLegend: true,
      }
      dataPoints = generate_dataPoints(i, last_6_months, month_totals)
      data_helper[:dataPoints] = dataPoints
      @options_1[:data] << data_helper
    end
    @options_1 = @options_1.to_json
    puts @options_1

    # {
    #   type: "column",
    #   name: "#{Type.where('id = ?', i+1).name}",
    #   showInLegend: true,
    #   dataPoints: []
    # }

    # end graph-1

    # graph-2
    # end graph-2
    # graph-3
    # end graph-3
    # graph-4
    # end graph-4

    respond_to do |format|
      format.js
      format.html
    end

  end

  protected

  def generate_dataPoints (typeId, l6months, totals)
    result = []
    n = l6months.length
    n.times do |i|
      result << {label: l6months[i].strftime('%b-%Y'), y: totals[l6months[i].strftime('%b-%Y')][typeId+1]}
    end
    result
  end
end
