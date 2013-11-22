puts "Welcome to James' coffee emporium!\n
  1) Add item - $5.00 - Light Bag
  2) Add item - $7.50 - Medium Bag
  3) Add item - $9.75 - Bold Bag
  4) Complete Sale \n\n"

@prices = {"1" => {price: 5.0, desc:"light", quant: 0},
           "2"=>{price:7.5, desc:"medium", quant: 0},
           "3"=>{price:9.75, desc:"bold", quant: 0}}

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

until choice == '4'
  quantity = ask_quantity(choice)
  item_subtotal = find_item_price(choice) * quantity
  running_total += item_subtotal
  puts 'Subtotal: $' + sprintf('%.2f' % running_total)
  choice = ask_item
end

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
    puts "\n===Thank You!==="
    puts 'The total change due is $' + sprintf('%.2f' % change)
    puts Time.now.strftime('%D %r')
    puts '================'
  end
end
