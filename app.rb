require "sinatra"
require "sinatra/activerecord"
require "./config/database"
require "./models/expense"
require "csv"

# Homepage - list expenses
get "/" do
  @expenses = Expense.order(date: :desc)
  erb :index
end

# Form to add new expense
get "/expenses/new" do
  erb :new
end

# Handle new expense form
post "/expenses" do
  Expense.create(params[:expense])
  redirect "/"
end

# View expenses by category/month
get "/report" do
  @by_category = Expense.group(:category).sum(:amount)
  @by_month = Expense.group("strftime('%Y-%m', date)").sum(:amount)
  erb :report
end

# Export CSV
get "/export.csv" do
  content_type "application/csv"
  attachment "expenses.csv"
  CSV.generate do |csv|
    csv << ["Date", "Category", "Amount", "Description"]
    Expense.all.each do |e|
      csv << [e.date, e.category, e.amount, e.description]
    end
  end
end
