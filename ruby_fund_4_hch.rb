# Ruby Fundamentals 4:  Challenge

# HCH changes:  moved methods up top, added comment for products CSV.foreach loop, added some comments on methods

# TO DO:
1. Replace refereces to @prices w/ references to products array
2.

require 'csv'
require 'pry'
require 'date'

# DATA

products = []

CSV.foreach('products.csv', headers: true) do |row|
  products << { name: row[0], sku: row[1], price: row[2], wholesale_price: row[3] }
end

# => This results in the following "products" array of "product" hashes:
# [{:name=>"light", :sku=>"123", :price=>"5.0", :wholesale_price=>"2.5"},
#  {:name=>"medium", :sku=>"456", :price=>"7.5", :wholesale_price=>"4.0"},
#  {:name=>"bold", :sku=>"789", :price=>"9.75", :wholesale_price=>"5.0"}]

sales = []

# sales = something from CSV, which we can then use to report things
# push single sale to CSV so can pull from later.
# current_sale = [date, light, medium, bold]
# (A single sale corresponds to running through the program once, till successful exit.)

sales = [
  { date: Date.new(2013,11,21),
    items: [{name: "light", quantity: 2}, {name: "medium", quantity: 1}]
    },
  { date: Date.new(2013,11,22),
    items: [{name: "light", quantity: 1}, {name: "medium", quantity: 1}, {name: "bold", quantity: 3}]
    }
  ]

# METHODS

        # ****** METHODS FROM EARLIER PROGRAM *******

# Checks if one of the valid choices is entered.
def is_valid_item?(input)
  /\A[1234]\z/.match(input)
end

# Checks if input is valid currency, used for amount tendered.
def is_valid_num?(input)
  /\A[0-9]+\.[0-9]{2}$/.match(input)
end

def ask_quantity(choice)
  puts "How many bags?"
  quantity = gets.chomp.to_i
  @prices[choice][:quant] += quantity
  # should be sale[choice] += quantity
  quantity
end

def ask_item
  puts 'What item is being purchased?'
  item = gets.chomp
  if is_valid_item?(item)
    item
  else
    puts "not valid input"
    ask_item
  end
end

# modified this method to use products array
# choice will be 1-3, corresponding to 0-2 in the products array
def find_item_price(choice, products)
  # @prices[choice][:price]
  products[choice-1][:price]
end

# do we use (or need) this method?  I don't think so
def find_item_description(choice, products)
  #@prices[choice][:desc]
  products[choice-1][:name]
end

        # ****** NEW METHODS *******

# we will set daily_sales = sales_for(date), then use daily_sales to run other reports
def sales_for(date)
  sales.select {|sale| sale[:date] == date}
end

def daily_items(daily_sales) # sales is array of hashes, returns integer (total quantity)
  total_items = 0
  daily_sales.each do |sale|
    sale[:items].each do |item|
      total_items += item[:quantity]
    end
  end
  total_items
end

def daily_gross(daily_sales, products)
  gross_sales = 0
  daily_sales.each do |sale|
    sale[:items].each do |item|
      gross_sales += item[:quantity] * retail_price(item[:name], products)
    end
  end
  gross_sales
end

def daily_cost(daily_sales, products)
  cost = 0
  daily_sales.each do |sale|
    sale[:items].each do |item|
      cost += item[:quantity] * wholesale_price(item[:name], products)
    end
  end
  cost
end

def daily_profits(gross, cost) # gross and cost are returned from calling the corresponding methods
  gross - cost
end

def retail_price(name, products) # given name as a string; may not be useful / efficient
  products.find { |product| product[:name] == name }[:price]
end

def wholesale_price(name, products)
  products.find { |product| product[:name] == name }[:wholesale_price]
end



# PROGRAM

puts "Welcome to James' coffee emporium! What would you like to do today?"
puts "1) Sell coffee to a customer"
puts "2) Get a report of past sales"

selection = gets.chomp.to_i

if selection == 1

  @prices = {"1" => {price: 5.0, desc:"light", quant: 0},
             "2"=>{price:7.5, desc:"medium", quant: 0},
             "3"=>{price:9.75, desc:"bold", quant: 0}}

  # Later, maybe recreate this output based on the products CSV

  puts "Now we are selling coffee!\n
    1) Add item - $5.00 - Light Bag
    2) Add item - $7.50 - Medium Bag
    3) Add item - $9.75 - Bold Bag
    4) Complete Sale \n\n"

  sale = [Time.new, 0, 0, 0]

  choice = ask_item
  running_total = 0

  # choice is 1-4, quantity is integer

  until choice == '4'
    quantity = ask_quantity(choice)
    item_subtotal = find_item_price(choice) * quantity
    running_total += item_subtotal
    puts 'Subtotal: $' + sprintf('%.2f' % running_total)
    sale[choice.to_i] += quantity
    choice = ask_item
  end

  binding.pry

  # This constitutes one sale; enter into sales array

  puts '===Sale Complete==='
  puts

  @prices.keys.each do |i|
    num_bags = @prices[i][:quant]
    next if num_bags == 0
    subtotal = @prices[i][:price] * num_bags
    puts "$#{ sprintf('%.2f' % subtotal) } - #{ num_bags } #{ @prices[i][:desc] }"
  end

  puts "\nTotal: $" + sprintf('%.2f' % running_total)
  puts

  # calculate the change due, as before

  puts 'What is the amount tendered?'
  tendered = gets.chomp

  if !is_valid_num?(tendered)
    puts 'WARNING: Invalid currency detected! Exiting...'
  else
    change = tendered.to_f - running_total
    if change < 0
      print 'WARNING: Customer still owes $' + sprintf('%.2f' % change.abs)
      puts '! Exiting...'
    else
    # success point, append sale array to sales.csv

      puts "\n===Thank You!==="
      puts 'The total change due is $' + sprintf('%.2f' % change)
      puts Time.now.strftime('%D %r')
      puts '================'
    end
  end

else

# REPORTING SECTION

# report of sales for given date (with each sale on its own line,
# plus summary info - gross sales, net profit, & items sold)

# get date

  puts "Enter date (in MM/DD/YYYY format):"
  input = gets.chomp.split('/')
  # how to check validity of date?
  is_valid_date?
  date = Time.new(input[2],input[0],input[1])

def is_valid_date?(input)

# generate report of sales for that date range

end
