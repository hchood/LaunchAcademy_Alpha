# Ruby Fundamentals IV:  Non-core Change Machine Kata

amount_due = rand(0.0..100.0)  # is amount_due a float or integer?  should be a float.

puts "Amount Due: #{sprintf("%.2f", amount_due)}\n\nWhat did customer supply?"
amount_tendered = gets.chomp.to_f
# test if amount_tendered is valid

change_due = amount_tendered - amount_due
num_dollars =


# only puts currency where num_currency > 0
puts "The change due is $#{sprintf("%.2f", change)}\n\nYou should issue:\n\n #{num_dollars} dollars\n#{num_quarters} quarters\n#{num_dimes} dimes\n"


