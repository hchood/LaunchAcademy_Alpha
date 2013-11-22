# Ruby Fundamentals IV:  Ruby Data Structures Assignment

characters = {
  "Tyrion Lannister" => "House Lannister",
  "Jon Snow" => "Night's Watch",
  "Hodor" => "House Stark",
  "Stannis Baratheon" => "House Baratheon",
  "Theon Greyjoy" => "House Greyjoy"
}

character_list = []

characters.each do |char_name, char_house|
  character = {name: char_name, house: char_house}
  character_list << character
end

character_list.each {|char| puts "#{char[:name]} represents the #{char[:house]}"}
