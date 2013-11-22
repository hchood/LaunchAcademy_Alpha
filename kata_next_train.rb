#  User Stories Kata:  The Next Train

# INPUT DATA

lyrics = "\n***DON'T STOP...BELIEVIN'!***

Just a small town girl
Living in a lonely world
She took the midnight train going anywhere
Just a city boy
Born and raised in South Detroit
He took the midnight train going anywhere

A singer in a smoky room
A smell of wine and cheap perfume
For a smile they can share the night
It goes on and on and on and on

Strangers waiting, up and down the boulevard
Their shadows searching in the night
Streetlights people, living just to find emotion
Hiding, somewhere in the night."


train_schedule = [
  {train_number: 1,   departure_time: 2},
  {train_number: 2,   departure_time: 5},
  {train_number: 3,   departure_time: 7.5},
  {train_number: 4,   departure_time: 8.5},
  {train_number: 5,   departure_time: 9},
  {train_number: 6,   departure_time: 10},
  {train_number: 7,   departure_time: 11.5},
  {train_number: 8,   departure_time: 13.5},
  {train_number: 9,   departure_time: 14.5},
  {train_number: 10,  departure_time: 17},
  {train_number: 11,  departure_time: 18},
  {train_number: 12,  departure_time: 19},
  {train_number: 13,  departure_time: 24}
]

# METHOD DEFINITIONS

def next_train(time, train_schedule)
  if time >= train_schedule[11][:departure_time]
    your_train = train_schedule[12]
  else
    i = 0
    i += 1 until time < train_schedule[i][:departure_time]
    your_train = train_schedule[i]
  end
end

def is_valid?(time)
  true if time > 0 && time <= 24
end

# PROGRAM

puts "What time are you leaving?"
time = gets.chomp.to_i
until is_valid?(time)
  puts "Please enter a time between 0 and 24."
  time = gets.chomp.to_i
end
puts "You should catch Train #{next_train(time, train_schedule)[:train_number]} leaving at #{next_train(time, train_schedule)[:departure_time]}."
puts lyrics if next_train(time, train_schedule)[:train_number] == 13

