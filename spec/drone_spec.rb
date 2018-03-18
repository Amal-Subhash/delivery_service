require 'spec_helper'

describe Drone do

  before :each do
    @drone_name = 'Dr_drone'
    @drone_code = 'Dr01'
    @wh_name = 'WareHouse_kochi'
    @wh_code = 'Wh_koc'
    @wh_address = 'kochi'
    @item = Item.new('Rolex', 'R1')
    @items_hash = {"R1"=>{:count=>5, :item=>@item}}
    @ware_house =  WareHouse.new(@name, @code, @address, @items_hash)
    @spot = @ware_house.get_pick_up_spot
    allow_any_instance_of(Drone).to receive(:transit)
    allow_any_instance_of(Drone).to receive(:puts)
  end

  describe "#initialize" do
    it "should create a drone with entered name and code" do
      drone = Drone.new(@drone_name, @drone_code)
      expect(drone.name).to eq @drone_name
      expect(drone.code).to eq @drone_code
    end

    it "should set status as ready" do
      drone = Drone.new(@drone_name, @drone_code)
      expect(drone.status).to eq 'ready'
    end
  end

  describe "#go_to_warehouse_pick_up" do
    it "should set the spot status as occupied" do
      drone = Drone.new(@drone_name, @drone_code)
      drone.go_to_warehouse_pick_up_spot(@ware_house, @spot)
      expect(@spot.status).to eq "occupied"
    end
  end

  describe "#out_for_delivery" do
    it "should set the spot status as available" do
      drone = Drone.new(@drone_name, @drone_code)
      drone.out_for_delivery(@item, @spot)
      expect(@spot.status).to eq "available"
    end
  end

  describe "#collect_customer_signature" do
    it "should set the delievered status of destination as true" do
      dest_name = 'MYHouse'
      dest_address = 'Bangalore'
      destination =  Destination.new(dest_name, dest_address)
      drone = Drone.new(@drone_name, @drone_code)
      drone.collect_customer_signature(destination)
      expect(destination.delivered).to eq true
    end
  end
end
