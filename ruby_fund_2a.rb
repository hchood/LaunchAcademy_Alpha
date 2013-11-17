# Ruby Fundamentals II - CHALLENGE

# New acceptance Criteria:

# I am prompted to enter a sale price for an item
# If I specify a valid amount of currency, the item is added to a list, and it updates the subtotal
# If I specify an invalid amount of currency, the item is not added to the list, and the subtotal is unaffected

def check_and_format(amount)
  formatted_amount = nil

  if amount.match(/[0-9]*[.][\d]{2}\z/)
    formatted_amount = amount.to_f
  else
    puts "WARNING: Invalid currency detected! Exiting..."
    abort
  end

  formatted_amount
end

# GET AMOUNTS DUE AND TENDERED FROM USER; CHECKS VALIDITY OF AMOUNTS & CONVERTS TO FLOAT

puts "What is the amount due?"
amount_due = gets.chomp
amount_due = check_and_format(amount_due)

puts "What is the amount tendered?"
amount_tendered = gets.chomp
amount_tendered = check_and_format(amount_tendered)

# CALCULATE CHANGE DUE & PRINT RECEIPT or EXIT

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
