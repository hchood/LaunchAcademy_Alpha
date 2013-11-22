# Ruby Fundamentals III - Challenge

#  NOTE:  I worked on this with Jonah and then refactored on my own.

require 'pry'

# METHOD DEFINITIONS

def get_input(prompt)
  puts prompt
  input = gets.chomp.to_i  # PROBLEM! Rounds amount tendered down to integer.
end

def validate_input(input, regex, error_message)
  while input.to_s.match(regex)
    puts error_message
    input = gets.chomp.to_i
  end
  input
end

def valid?(price)
  if price.match(/\A\d+(\.\d{0,2})?\z/)
    true
  end
end

def calc_subtotals(array)
 array.each do |hash|
   hash[:subtotal] = hash[:quantity] * hash[:price]
 end
end

def total(array)
 array = calc_subtotals(array)
 products = []
 array.each {|hash| products << hash[:subtotal]}
 products.inject(0) {|total, num| total + num}
end

# INITIALIZED VARIABLES

sales = [{type: "Light", price: 5.00, quantity: 0, subtotal: 0},
       {type: "Medium", price: 7.50, quantity: 0, subtotal: 0},
       {type: "Bold",   price: 9.75, quantity: 0, subtotal: 0}]

# PROGRAM

puts "Welcome to James' coffee emporium!\n
  1) Add item - $5.00 - Light Bag
  2) Add item - $7.50 - Medium Bag
  3) Add item - $9.75 - Bold Bag
  4) Complete Sale\n\n"

  # PART 1: gets input (items & quantity sold), puts subtotal

while true
  selection = get_input("Make a selection:")
  selection = validate_input(selection, /[^1-4]/, "Please enter a selection 1 through 4.")
  break if selection == 4
  quantity = get_input("How many bags:")
  quantity = validate_input(quantity, /\D/, "Please enter a number.")
  sales[selection - 1][:quantity] += quantity
  subtotal = total(sales)
  puts "Subtotal: $#{sprintf("%.2f", subtotal)}\n\n"
end

if total(sales) == 0
  puts "You did not sell anything.  Goodbye!"
  exit
end

  # PART 2:  when finished adding sales, output subtotals & total due

puts "\n===Sale Complete===\n\n"

sales.each do |item|
  puts "$#{sprintf("%.2f", item[:subtotal])} - #{item[:quantity]} #{item[:type]}\n" unless item[:subtotal] == 0
end
puts "\nTotal: $#{sprintf("%.2f", subtotal)}\n\n"

  # PART 3:  calculates change

amount_due = subtotal
amount_tendered = get_input("What is the amount tendered?")  # PROBLEM!  Amount tendered rounded down to nearest integer
if valid?(amount_tendered.to_s)
  amount_tendered = amount_tendered.to_f
else
  puts "WARNING: Invalid currency detected! Exiting..."
  abort
end

total_change_due = amount_tendered - amount_due
binding.pry

if total_change_due >= 0
  puts "\n===Thank You!==="
  puts "The total change due is $#{sprintf("%.2f", total_change_due.abs)}\n\n"
  puts "#{Time.now.strftime("%m/%d/%Y %l:%M %p")}"
  puts "================"
else
  puts "WARNING: Customer still owes $#{sprintf("%.2f", total_change_due.abs)}! Exiting..."
  abort
end
