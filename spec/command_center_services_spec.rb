# require 'spec_helper'

# describe CommandCenterServices do

#   before :each do
#     @command_services_obj = CommandCenterServices.new
#   end

#   describe "#create_items" do
#     it "should create an array of item objects" do
#       @command_services_obj.create_items
#       expect(@command_services_obj.items_array).not_to be nil
#       expect(@command_services_obj.items_array.first).to be_an_instance_of Item
#     end
#   end

#   describe "#create_warehouses" do
#     it "should create an array of active warehouses" do
#       @command_services_obj.create_warehouses
#       expect(@command_services_obj.active_warehouses).not_to be nil
#       expect(@command_services_obj.active_warehouses.first).to be_an_instance_of WareHouse
#     end
#   end

#   describe "#create_drone_fleet" do
#     it "should create an array of drone fleet" do
#       @command_services_obj.create_drone_fleet
#       expect(@command_services_obj.drone_fleet).not_to be nil
#       expect(@command_services_obj.drone_fleet.first).to be_an_instance_of Drone
#     end
#   end

#   describe "#select_drone" do
#     it "should return a drone with status 'ready' and condition 'good'" do
#       @command_services_obj.create_drone_fleet
#       @command_services_obj.select_drone
#       expect(@command_services_obj.select_drone.status).to eq('ready')
#       expect(@command_services_obj.select_drone.condition).to eq('good')
#     end
#   end
# end
