require 'test_helper'

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  end

  test "get index: is successful" do
    get expenses_path, params: {type_id: 1, category_id: 3, date: 1}
    assert_response :success
    
  end

  test "get new_modal: is successful" do
    get new_expense_path
    assert_response :success
  end

  test "get edit_modal: is successful" do
    get "/expenses/#{expenses(:expense_1).id}/edit", xhr: true
    assert_response :success
  end

  test "post create: is successful" do
    post '/expenses', params: { expense: {type_id: 1, category_id: 2, date: '2017-11-26', amount: 3000, concept: 'Yao Ming'}}, xhr: true
    assert_response :success
  end

  test "patch update: is successful" do
    patch "/expenses/#{expenses(:expense_1).id}", params: { expense: {type_id: 1, category_id: 2, date: '2017-11-26', amount: 5000, concept: 'Try-testing'}}, xhr: true
    assert_response :success
  end

  test "delete expense: is successful" do
    delete "/expenses/#{expenses(:expense_1).id}", xhr: true
    assert_response :success
  end

  test "user get index" do
    visit '/expenses'
    click_link "New Expense"
    select('Retiro', from: 'expense_type_id')
    fill_in "Date", with: "2022019"
    select('Gym', from: 'expense_category_id')
    fill_in "Concept", with: "Esto es un test automatizado"
    fill_in "Amount", with: "100000"
    click_button "Create expense"
    assert page.has_content?("Expense successfully created")
    assert page.has_css?(".close")
    find(".close", match: :first).click
    #inicia prueba de edicion
    click_button "March 2019"
    click_link "February 2019"
    assert page.has_css?(".glyphicon-edit", :visible => :all)
    find(".actions").hover.find('.edit').click
    select('Compra', from: 'expense_type_id')
    fill_in "Date", with: "2022019"
    select('Gym', from: 'expense_category_id')
    fill_in "Concept", with: "Esto es un edit de un test automatizado"
    fill_in "Amount", with: "1000000"
    click_button "Edit expense"
    assert page.has_content?("Expense successfully updated")
    #inicia prueba de borrado
    find(:xpath,'//*[@id="expenses-table"]').hover.find(:xpath,'//tbody/tr[1]/td[4]/div[2]/a[2]').click
    page.accept_alert  
    assert page.has_content?("Expense successfully deleted")
  end

end
