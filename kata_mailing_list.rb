# Ruby Fundamentals III - Kata

# INPUT ARRAYS

salutations = [
  ['Mr.', 'Mrs.'],
  'Mrs.',
  ['Mr.', 'Mrs.'],
  ['Dr.'],
  'Ms.'
]

first_names = [
  'John',
  'Jane',
  'Sam',
  'Louise',
  'Kyle'
]

last_names = [
  'Dillinger',
  'Cook',
  'Livingston',
  'Levinger',
  'Merlotte'
]

addresses = [
  '33 Foolish Lane, Boston MA 02210',
  '45 Cottage Way, Dartmouth, MA 02342',
  "54 Sally's Court, Bridgewater, MA 02324",
  '4534 Broadway, Boston, MA 02110',
  '4231 Cynthia Drive, Raynham, MA 02767'
]

# METHOD DEFINITIONS

def salutation(person)
  if person[:salutation].class == String
    person[:salutation]
  elsif person[:salutation].class == Array && person[:salutation].length == 1
    person[:salutation][0]
  else
    "#{person[:salutation][0]} & #{person[:salutation][1]}"
  end
end

def name_and_address(person)
  "#{person[:first_name]} #{person[:last_name]}\n#{person[:address]}"
end

# PROGRAM

people = []

5.times do |i|
  person = {salutation: salutations[i],
            first_name: first_names[i],
            last_name:  last_names[i],
            address:    addresses[i]}
  people << person
end

people.each do |person|
  puts "#{salutation(person)} #{name_and_address(person)}"
end
