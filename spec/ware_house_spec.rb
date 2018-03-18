require 'spec_helper'

describe WareHouse do

  before :each do
    @name = 'WareHouse_kochi'
    @code = 'Wh_koc'
    @address = 'kochi'
    @item = Item.new('Rolex', 'R1')
    @items_hash = {"R1"=>{:count=>5, :item=>@item}}
  end

  describe "#initialize" do

    it "should create a WareHouse with entered values" do
      ware_house =  WareHouse.new(@name, @code, @address, @items_hash)
      expect(ware_house.name).to eq @name
      expect(ware_house.code).to eq @code
      expect(ware_house.address).to eq @address
    end

    it "should create pick_up_spots for warehouse" do
      ware_house =  WareHouse.new(@name, @code, @address, @items_hash)
      expect(ware_house.pick_up_spots).not_to be nil
    end

    it "should set number of active_processes as 0" do
      ware_house =  WareHouse.new(@name, @code, @address, @items_hash)
      expect(ware_house.active_processes).to eq 0
    end
  end

  describe "#get_pick_up_spot" do
    it "should return a pick up spot of warehouse" do
      ware_house =  WareHouse.new(@name, @code, @address, @items_hash)
      expect(ware_house.get_pick_up_spot).not_to be nil
    end

    it "should return a pick up spot of warehouse with status as available" do
      ware_house =  WareHouse.new(@name, @code, @address, @items_hash)
      expect((ware_house.get_pick_up_spot).status).to eq 'available'
    end

    it "should increment the number of active_processes by 1" do
      ware_house =  WareHouse.new(@name, @code, @address, @items_hash)
      active_processes = ware_house.active_processes
      ware_house.get_pick_up_spot
      new_active_processes = ware_house.active_processes
      expect(new_active_processes - active_processes).to eq 1
    end
  end

  describe "#get_item_count" do
    it "should return the count of the item available at warehouse" do
      ware_house =  WareHouse.new(@name, @code, @address, @items_hash)
      expect(ware_house.get_item_count(@item.code)).not_to be nil
    end
  end

  describe "#get_item" do
    it "should return the item available at warehouse" do
      ware_house =  WareHouse.new(@name, @code, @address, @items_hash)
      expect(ware_house.get_item(@item.code)).to be_an_instance_of Item
    end
  end
end
