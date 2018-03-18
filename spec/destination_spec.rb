require 'spec_helper'

describe Destination do

  before :each do
    @name = 'MYHouse'
    @address = 'Bangalore'
    @item = Item.new('Rolex', 'R1')
  end

  describe "#initialize" do
    it "should create a Destination with entered values" do
      destination =  Destination.new(@name, @address)
      expect(destination.name).to eq @name
      expect(destination.address).to eq @address
    end

    it "should set the Destination delivered attribute as false" do
      destination =  Destination.new(@name, @address)
      expect(destination.delivered).to eq false
    end
  end
end
