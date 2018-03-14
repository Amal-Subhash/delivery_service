class WareHouse
  attr_accessor :name, :code, :address, :pick_up_spots, :active_processes

  def initialize(name, code, address, items_hash)
    @name = name
    @code = code
    @address = address
    @items_hash = {}
    @items_hash.merge!(items_hash)
    @pick_up_spots = []

    Struct.new("Pick_up", :name, :code, :status)
    (0..1).each do |i|
      @pick_up_spots << Struct::Pick_up.new("spot#{i}", "code#{i}", "available")
    end

    @active_processes = 0
  end

  # Method of getting the available pick up spot of ware house.
  def get_pick_up_spot
    @pick_up_spots.each do |spot|
      return spot if spot.status == "available"
    end
  end

  def get_item_count(item_code)
  	@items_hash[item_code][:count]
  end

  def get_item(item_code)
    @items_hash[item_code][:item]
  end
end
