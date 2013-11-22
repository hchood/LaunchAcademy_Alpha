# Ruby Fundamentals 4:  Challenge

require 'csv'
require 'pry'
require 'date'

# DATA

products = []

CSV.foreach('products.csv', headers: true) do |row|
#  balance += row[0].to_f
  products << { name: row[0], sku: row[1], price: row[2], wholesale_price: row[3] }
end

# METHODS

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

  # Checks if one of the valid choices is entered.
  def is_valid_item?(input)
    /\A[1234]\z/.match(input)
  end

  # Checks if input is valid currency, used for amount tendered.
  def is_valid_num?(input)
    /[0-9]+\.[0-9]{2}$/.match(input)
  end

  def ask_quantity(choice)
    puts "How many bags?"
    quantity = gets.chomp.to_i
    @prices[choice][:quant] += quantity
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

  def find_item_price(choice)
    @prices[choice][:price]
  end

  def find_item_description(choice)
    @prices[choice][:desc]
  end

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


end
