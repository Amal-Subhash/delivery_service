Dir["classes/**/*.rb"].each {|file| require_relative file } # Loading all classes from classes directory.
require 'pry'
require 'colorize'

puts `clear`
puts "\n\t\t\t\tPlease complete the following prerequisites before starting the application.".green
puts "\n\t\t\t\t\t============================================================".yellow
@command_services_obj = CommandCenterServices.new
@command_services_obj.create_items
@command_services_obj.create_warehouses
@command_services_obj.create_drone_fleet

#           Application begins from here.
#=================================================

while true
  puts `clear`
  puts "\n\t\t\t\t\t\t\tRedDartDrones Delivery Services".red
  puts "\n\t\t\t\t\t\t===========================================".green

  @command_services_obj.get_item_code

  puts "\nPlease enter the house name of the delivery address"
  house_name = gets.chomp
  puts "\nPlease enter the delivery address of the item to be delivered"
  delivery_address = gets.chomp
  destination_obj = Destination.new(house_name, delivery_address)

  drone_obj = @command_services_obj.select_drone # returns a drone from a fleet of drones, based on drone status and condtion.
  drone_obj.status = "at_work"

  warehouse_obj = @command_services_obj.select_warehouse(@command_services_obj.item_code) # returns a warehouse based on based on item availability and least active processes.
  spot = warehouse_obj.get_pick_up_spot # returns selected warehouse's available pick_up spot.
  item_obj = warehouse_obj.get_item(@command_services_obj.item_code) # returns Item object from warehouse's items_hash attribute.

  puts "\n--------------------------------------------------------".yellow
  puts "\nThe drone: #{drone_obj.name} has been sent to the warehouse: #{warehouse_obj.name}, pick up spot: #{spot.name}".cyan
  puts "\n--------------------------------------------------------".yellow
  drone_obj.go_to_warehouse_pick_up_spot(warehouse_obj, spot)
  puts "\n--------------------------------------------------------".yellow
  drone_obj.load_item(item_obj, spot)
  puts "\n--------------------------------------------------------".yellow
  drone_obj.go_to_destination(destination_obj)
  puts "\n--------------------------------------------------------".yellow
  drone_obj.unload_item(item_obj)
  puts "\n--------------------------------------------------------".yellow
  drone_obj.collect_customer_signature(destination_obj)
  drone_obj.status = "done"
  destination_obj.item_delivery_status(item_obj)
  puts "\n--------------------------------------------------------".yellow
  spot = warehouse_obj.get_pick_up_spot
  drone_obj.go_to_warehouse_pick_up_spot(warehouse_obj, spot)
  warehouse_obj.active_processes-= 1

  puts "\n-----------------------------------------".yellow
  puts "\n\t Do you want to exit ? (Enter Y or N)".red
  break if gets.chomp.downcase == 'y'
end
