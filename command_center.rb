Dir["classes/**/*.rb"].each {|file| require_relative file }
require 'pry'

puts "Please complete the following prerequisites before starting the application."

#For creating items for delivery.
items_array = []
(0..1).each do |i|
  puts "\n================================"
  puts "Add new Item :"
  puts "Please enter the name of the product"
  name = gets.chomp
  puts "Please enter the product code"
  code = gets.chomp
  items_array << instance_variable_set("@item#{i}", Object.const_get("Item").new(name, code))
end  

#For creating warehouse.
(0..0).each do |i|
  puts "\n================================"
  puts "Add a warehouse :"
  puts "Please enter the name of the warehouse"
  name = gets.chomp
  puts "Please enter the warehouse code"
  code = gets.chomp
  puts "Please enter the warehouse address"
  address = gets.chomp
  item_hash = {}

  items_array.each do |item|
    puts "Please enter the number of available #{item.name} at the WareHouse #{name}"
    item_hash["#{item.code}"] = {count: gets.chomp.to_i, item: item}
  end

  instance_variable_set("@warehouse#{i}", Object.const_get("WareHouse")
    .new(name, code, address, item_hash))
end 

#For creating and initializing drones.
drone_fleet = []
(0..0).each do |i|
  puts "\n================================"
  puts "Create new Drone :"
  puts "Please enter the name of the drone"
  name = gets.chomp
  puts "Please enter the drone code"
  code = gets.chomp
  drone_fleet << instance_variable_set("@drone#{i}", Object.const_get("Drone").new(name, code))
end




