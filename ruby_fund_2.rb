# Ruby Fundamentals II - CHALLENGE
# Cashier problem totals purchases, outputs subtotals, calculates changes, & prints receipt.

# METHOD DEFINITIONS

def gets_price
  puts "What is the sale price?"
  gets.chomp
end

def valid?(price)
  if price.match(/\A\d+(\.\d{0,2})?\z/)
    true
  end
end

def subtotal(list)
  subtotal = list.inject(0){ |total, num| total += num }
  subtotal = sprintf("%.2f", subtotal)
end

# CASHIER PROGRAM

  # PART 1:  obtains prices, adds to list, & outputs subtotal

list = []

while true
  price = gets_price
  if price == "done"
    break
  elsif valid?(price)
    price = price.to_f
    list = list << price
    puts "Subtotal: $#{subtotal(list)}"
  else
    puts "You must enter a valid number."
  end
end

  # PART 2:  when finished adding prices, outputs list of prices & subtotal

puts "Here are your item prices:"
puts
list.each do |item|
  item = sprintf("%.2f", item)
  puts "$#{item}"
end
puts
puts "The total amount due is $#{subtotal(list)}"

amount_due = subtotal(list).to_f

puts "What is the amount tendered?"
amount_tendered = gets.chomp
if valid?(amount_tendered)
  amount_tendered = amount_tendered.to_f
else
  puts "WARNING: Invalid currency detected! Exiting..."
  abort
end

  # PART 3:  calculates changes & prints receipt

total_change_due = amount_tendered - amount_due
total_change_due_formatted = sprintf("%.2f", total_change_due.abs)

if total_change_due >= 0
  current_time = Time.now.strftime("%m/%d/%Y %l:%M %p")
  puts "===Thank You!==="
  puts "The total change due is $#{total_change_due_formatted}"
  puts
  puts "#{current_time}"
  puts "================"
else
  puts "WARNING: Customer still owes $#{total_change_due_formatted}! Exiting..."
  abort
end
