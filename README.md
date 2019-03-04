
# Personal Finances 

## This is a small application to manage personal finances, you can graphically see your expenses, and manage them through an API, which has many ways to filter and organize your information

### API INFORMATION: 

%URL% = Your url or localhost, if you want try a DEMO replase %URL% for **Strong** __https://personalexpensify.herokuapp.com__

%PATH% = %URL%/api/v1/expenses?

For multiple filters you have to use "&" yo split the filters, example: https://personalexpensify.herokuapp.com/api/v1/expenses?month=10&year=2018&category=baby

#### Get requests:

* Filter by category: %PATH%__category__=[categoryName] ---> you get all registers by category name 

* Filter by type: %PATH%__type__=[typeName] ---> you get all registers by type name 

* Filter by category_id: %PATH%__category_id__=[categoryId] ---> you get all registers by tipe id

* Filter by type_id: %PATH%__type_id__=[typeId] ---> you get all registers by type id

* Filter by year: %PATH%__year__=[yearNumber] ---> you get all registers by year number

* Filter by month: %PATH%__month__=[monthNumber] ---> you get all registers by month number

* Filter by day: %PATH%__day__=[dayNumber] ---> you get all registers by day number

* Filter by beginDate: %PATH%__beginDate__=[date] --->format: dd/mm/yyyy or dd-mm-yyyy , you get all registers by beginDate

* Filter by endDate: %PATH%__endDate__=[date] --->format: dd/mm/yyyy or dd-mm-yyyy , you get all registers by endDate

* Filter by concept: %PATH%__concept__=[concept] ---> you get all registers by day concept 

* Filter by page number: %PATH%__page__=[pageNumber] ---> you get all paginated registers, by default is 10 registers by request

* Filter by startAmount: %PATH%__startAmount__=[minAmount] ---> you get all registers by minAmount 

* Filter by endAmount: %PATH%__endAmount__=[maxAmount] ---> you get all registers by maxAmount






