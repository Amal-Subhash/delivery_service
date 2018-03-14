Dir["classes/**/*.rb"].each {|file| require_relative file } # Loading all classes.
require 'pry'

puts `clear`
puts "\n\t\t\t\tPlease complete the following prerequisites before starting the application."
puts "\n\t\t\t\t\t============================================================"

# For creating items for delivery.
items_array = []
(0..1).each do |i|
  puts "Add new Item :"
  puts "Please enter the name of the product"
  name = gets.chomp
  puts "Please enter the product code"
  code = gets.chomp
  items_array << instance_variable_set("@item#{i}", Object.const_get("Item").new(name, code))
  puts "\n================================"
end

# For creating warehouse.
@active_warehouses = []
(0..1).each do |i|
  puts "Add a warehouse :"
  puts "Please enter the name of the warehouse"
  name = gets.chomp
  puts "Please enter the warehouse code"
  code = gets.chomp
  puts "Please enter the warehouse address"
  address = gets.chomp
  items_hash = {}

  items_array.each do |item|
    puts "Please enter the number of available #{item.name} at the WareHouse #{name}"
    items_hash["#{item.code}"] = {count: gets.chomp.to_i, item: item}
  end

  @active_warehouses << instance_variable_set("@warehouse#{i}", Object.const_get("WareHouse")
                                              .new(name, code, address, items_hash))
  puts "\n================================"
end

# For creating and initializing drones.
@drone_fleet = []
(0..0).each do |i|
  puts "Create new Drone :"
  puts "Please enter the name of the drone"
  name = gets.chomp
  puts "Please enter the drone code"
  code = gets.chomp
  @drone_fleet << instance_variable_set("@drone#{i}", Object.const_get("Drone").new(name, code))
  puts "\n================================"
end

#           Application begins from here.
#=================================================
puts `clear`
puts "\n\t\t\t\t\t\t\tRedDartDrones Delivery Services"
puts "\n\t\t\t\t\t\t==========================================="
puts "\n\n Please enter the item code of the item to be delivered"
@item_code = gets.chomp
puts "\n Please enter the house name of the delivery address"
house_name = gets.chomp
puts "\n Please enter the delivery address of the item to be delivered"
delivery_address = gets.chomp
@destination = Destination.new(house_name, delivery_address)

# Method for selecting a drone based on drone status and condition.
def select_drone
  @drone_fleet.shuffle.each do |drone|
    return drone if drone.status.eql?('ready') && drone.condition.eql?('good')
  end
end
@drone = select_drone
@drone.status = "at_work"

# Method for selecting a warehouse based on item availabilty and least active processes.
def select_warehouse
  @active_warehouses.sort! { |a, b|  a.active_processes <=> b.active_processes }
  @active_warehouses.each do |warehouse|
    return warehouse if warehouse.get_item_count(@item_code) > 0
  end
end
@warehouse = select_warehouse

spot = @warehouse.get_pick_up_spot # returns selected warehouse's available pick_up spot
@item = @warehouse.get_item(@item_code) # returns item object from ware_house items_hash

puts "\n The drone has been sent to the warehouse: #{@warehouse.name}, pick up spot: #{spot.name}"

@drone.go_to_warehouse_pick_up(@warehouse, spot)
@drone.load_item(@item)
@drone.go_to_destination(@destination)
@drone.unload_item(@item)
@drone.collect_customer_signature(@destination)
@drone.status = "done"

@destination.item_delivery_status(@item)

spot = @warehouse.get_pick_up_spot
@drone.go_to_warehouse_pick_up(@warehouse, spot)
