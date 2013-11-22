# Ruby Fundamentals 4:  Challenge

require 'csv'
require 'pry'
require 'date'

# DATA

products = []
CSV.foreach('products.csv', headers: true) do |row|
  products << { name: row[0], sku: row[1], price: row[2], wholesale_price: row[3] }
end

prices = []
products.each do |product|
  prices << [product[:name], product[:price]]
end
# prices = [["light", "5.0"], ["medium", "7.5"], ["bold", "9.75"]]

# HELPER METHODS

def is_valid_action?(input)
  /\A[12]\z/.match(input)
end

def is_valid_item?(input, products)
  n = products.length
  /\A[1-n]\z/.match(input) # how to deal with CSV of 10 or more products?
end

def is_valid_currency?(input)
  /\A[0-9]+\.[0-9]{2}$/.match(input)
end

# PROGRAM

puts "Welcome to James's coffee emporium!"
puts "1) Sell coffee to a customer"
puts "2) Get a report of past sales"
puts "What would you like to do today?"

action = gets.chomp
until is_valid_action?(action)
  puts "What would you like to do today?"
  action = gets.chomp
end

if action == "1"

  # Generate this output based on the products data structure
  puts "Now we are selling coffee!"
  puts "1) Add item - $5.00 - Light Bag"
  puts "2) Add item - $7.50 - Medium Bag"
  puts "3) Add item - $9.75 - Bold Bag"
  puts "4) Complete Sale"

  quantities = Array.new(products.length,0)
  sale = [Time.new]
  quantities.each do |quantity| # does this go here, or later down?
    sale << quantity
  end
  # prices = [["light", "5.0"], ["medium", "7.5"], ["bold", "9.75"]]
  # quantities = [0, 0, 0]
  # sale = [time, 0, 0, 0]

  def calc_subtotal(quantities, prices)
    subtotal = 0
    quantities.each_with_index do |quantity, index|
      subtotal += quantity * prices[index][1].to_f
    end
    subtotal
  end

  def ask_item(products)
    puts "What item is being purchased?"
    item = gets.chomp
    until is_valid_item?(item, products)
      puts "What item is being purchased?"
      item = gets.chomp
    end
    item
  end

  item = ask_item(products)
  num_items = products.length

  until item == (num_items + 1).to_s
    puts "How many bags?"
    quantity = gets.chomp.to_i
    sale[item.to_i] += quantity
    quantities[item.to_i - 1] += quantity

    current_subtotal = calc_subtotal(quantities, prices)
    puts 'Subtotal: $' + sprintf('%.2f' % current_subtotal)
    item = ask_item(products)
  end
  # binding.pry

  puts '===Sale Complete==='
  puts

  def output_item_subtotals(quantities, prices)
    quantities.each_with_index do |quantity, index|
      item_subtotal = quantity * prices[index][1].to_f
      puts "$#{sprintf('%.2f' % item_subtotal)} - #{quantity} #{prices[index][0].capitalize}" unless quantity == 0
    end
  end

  output_item_subtotals(quantities, prices)

  # @prices.keys.each do |i|
  #   num_bags = @prices[i][:quant]
  #   next if num_bags == 0
  #   subtotal = @prices[i][:price] * num_bags
  #   puts "$#{ sprintf('%.2f' % subtotal) } - #{ num_bags } #{ @prices[i][:desc] }"
  # end

  puts "\nTotal: $" + sprintf('%.2f' % calc_subtotal(quantities, prices))
  puts

  # # calculate the change due, as before

  # puts 'What is the amount tendered?'
  # tendered = gets.chomp

  # if !is_valid_currency?(tendered)
  #   puts 'WARNING: Invalid currency detected! Exiting...'
  # else
  #   change = tendered.to_f - running_total
  #   if change < 0
  #     print 'WARNING: Customer still owes $' + sprintf('%.2f' % change.abs)
  #     puts '! Exiting...'
  #   else
  #   # success point, append sale array to sales.csv

  #     puts "\n===Thank You!==="
  #     puts 'The total change due is $' + sprintf('%.2f' % change)
  #     puts Time.now.strftime('%D %r')
  #     puts '================'
  #   end
  #  end

else


end
