class Destination
  attr_reader :name, :address
  attr_accessor :delivered

  def initialize(name, address)
    @name = name
    @address = address
    @delivered = false
  end

  # Method for printing the item delivery status, after the drone has collected
  # customer signature and updated the value for delivered attribute of destination.
  def item_delivery_status(item)
    if @delivered
      puts "\nThe item #{item.name} has been delivered"
    else
      puts "\nThe item #{item.name} has not been delivered"
    end
  end
end
