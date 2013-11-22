
# INPUT DATA

# products = [{ name: "light", sku: 123, price: 5.0, wholesale_price: 2.5 },
#             { name: "medium", sku: 456, price: 7.5, wholesale_price: 4.0 },
#             { name: "bold", sku: 789, price: 9.75, wholesale_price: 5.0 }]

require 'csv'
require 'pry'

products = []

CSV.foreach('products.csv', headers: true) do |row|
#  balance += row[0].to_f
  products << { name: row[0], sku: row[1], price: row[2], wholesale_price: row[3] }
end

binding.pry

# sales = something from CSV, which we can then use to report things
# push single sale to CSV so can pull from later.
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


# daily_sales = sales_for(date)
# retail_price(items[i][:name])
