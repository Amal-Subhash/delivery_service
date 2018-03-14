class Destination
  attr_reader :name, :address
  attr_accessor :delivered

  def initialize(name, address)
    @name = name
    @address = address
    @delivered = false
  end

  def item_delivery_status(item)
  	if item_delivered?
    	puts "\n The item #{item.name} has been delivered"
    else
    	puts "\n The item #{item.name} has not been delivered"
    end
  end

  # Boolean Method to check whether item has been delivered
  def item_delivered?
    @delivered
  end

end
