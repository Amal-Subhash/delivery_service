class WareHouse
  attr_reader :name, :code, :address, :pick_up_spots, :items_hash
  attr_accessor :active_processes

  def initialize(name, code, address, items_hash)
    @name = name
    @code = code
    @address = address
    @items_hash = {}
    @items_hash.merge!(items_hash)
    @pick_up_spots = []

    Struct.new("Pick_up", :name, :code, :status)
    (1..3).each do |i|
      @pick_up_spots << Struct::Pick_up.new("spot#{i}", "code#{i}", "available")
    end
    @active_processes = 0
  end

  # Method of getting the available pick up spot of a ware house.
  def get_pick_up_spot
    @active_processes+= 1
    @pick_up_spots.each do |spot|
      return spot if spot.status == "available"
    end
  end

  # Method for getting count of the item stored at warehouse.
  def get_item_count(item_code)
    @items_hash[item_code][:count]
  end

  # Method for getting item stored at warehouse.
  def get_item(item_code)
    @items_hash[item_code][:count]-= 1
    @items_hash[item_code][:item]
  end
end
