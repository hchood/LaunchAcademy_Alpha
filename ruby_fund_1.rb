# Ruby Fundamentals I - CHALLENGE

# ACCEPTANCE CRITERIA:

# I am prompted to supply the amount due.
# I am then prompted to supply the tender supplied by the customer
# The program outputs the total change due and the time at which it was calculated
# If the tender supplied by the customer is not enough to cover the amount due, the program warns me and exits immediately
# If I specify invalid input (not a valid number, too many decimal places), the program warns me and exits immediately

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

# GET AMOUNTS DUE AND TENDERED FROM USER; CHECKS & FORMATS AMOUNTS

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
