class WareHouse
  attr_reader :name, :code, :address, :pick_up_spots

  def initialize(name, code, address, item_hash)
    @name = name
    @code = code
    @address = address
    @item_hash = {}
    @item_hash.merge!(item_hash)
    @pick_up_spots = []
    Struct.new("Pick_up", :name, :code, :status)
    (0..1).each do |i|
      @pick_up_spots << Struct::Pick_up.new("spot#{i}", "code#{i}", "available")
    end
    p @item_hash, @pick_up_spots
  end
end
