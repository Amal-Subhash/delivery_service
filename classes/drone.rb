require_relative 'destination'

class Drone
  attr_reader :name, :code, :condition
  attr_accessor :status

  def initialize(name, code)
    @name = name
    @code = code
    @status = "ready"
    @condition = "good"
    @delivered = false
    # To be implemented in future.
    # @max_allowable_weight
  end

  # Method for drone to reach warehouse pick_up spot.
  def go_to_warehouse_pick_up(warehouse, spot)
    transit
    puts "\n Drone has reached the warehouse: #{warehouse.name} at pick_up spot: #{spot.name}."
    if @status.eql?('done')
    	@status = "ready"
    	puts "\n The drone is ready for next task"
    end
  end

  # Method for guiding drone while transit.
  def transit
    1.upto(100) do |i|
      progress = "=" * (i/5) unless i < 5
      printf("-\rtransit: [%-20s]", progress)
      sleep(0.1)
    end
  end

  # Method for loading the item.
  def load_item(item)
    puts "\n The item #{item.name} has been loaded."
    out_for_delivery(item)
  end

  # Method for dispatching
  def out_for_delivery(item)
  	puts "\n The item #{item.name} is out for delivery."
  end

  # Method for guiding the drone to destination.
  def go_to_destination(destination)
    transit
    puts "\n Drone has reached the destination: #{destination.name} at: #{destination.address}."
  end

  # Method for unloading the item.
  def unload_item(item)
    sleep(0.1)
    puts "\n The item #{item.name} has been unloaded."
  end

  # Method for collecting customer signature
  def collect_customer_signature(destination)
    destination.delivered = true
  end

  # Method for returning the current location status of the drone.
  def location_status
    puts "\n The drone is located at (#{get_latitude_and_longitude})."
  end

  # Method to return current location latitude and longitude.
  def get_latitude_and_longitude
  end

  # Method to know whether drone is in air or at ground.
  def get_fly_status
  end
end
