require 'colorize'

class Drone
  attr_reader :name, :code, :condition
  attr_accessor :status

  def initialize(name, code)
    @name = name
    @code = code
    @status = "ready" # ["ready","at_work", "done"] are the status values, default value: "ready"
    @condition = "good" # ["good", "in_repair", "down"] are the condition values, default value: "good"
    # To be implemented in future.
    # @max_allowable_weight
    # @delivered = false
  end

  # Method for drone to reach warehouse pick_up spot.
  def go_to_warehouse_pick_up_spot(warehouse, spot)
    transit
    sleep(2)
    puts "\n\nThe drone: #{@name} has reached the warehouse: #{warehouse.name} at pick_up spot: #{spot.name}.".cyan
    if @status.eql?('done')
      @status = "ready"
      sleep(2)
      puts "\n--------------------------------------------------------".yellow
      puts "\nThe drone: #{@name} is ready for next task".cyan
    end
    spot.status = "occupied"
  end

  # Method for controlling and guiding drone while transit.
  def transit
    1.upto(100) do |i|
      progress = "=" * (i/5) unless i < 5
      printf("-\rtransit: [%-20s]", progress)
      sleep(0.1)
    end
  end

  # Method for loading the item.
  def load_item(item, spot)
    sleep(3)
    puts "\nThe item #{item.name} has been loaded."
    puts "\n--------------------------------------------------------".yellow
    out_for_delivery(item, spot)
  end

  # Method for dispatching item.
  def out_for_delivery(item, spot)
    sleep(2)
    spot.status = "available"
    puts "\nThe item #{item.name} is out for delivery."
  end

  # Method for drone to reach destination.
  def go_to_destination(destination)
    transit
    sleep(3)
    puts "\n\nThe drone: #{@name} has reached the destination: #{destination.name} at: #{destination.address}.".cyan
  end

  # Method for unloading the item.
  def unload_item(item)
    sleep(3)
    puts "\nThe item #{item.name} has been unloaded."
  end

  # Method for collecting customer signature after delivery
  def collect_customer_signature(destination)
    sleep(3)
    destination.delivered = true
  end

  #To be implemented later

  # Method for returning the current location of the drone by passing lat and long to geocoder gem.
  def location_status
  end

  # Method to return current location latitude and longitude using geocoder gem.
  def get_latitude_and_longitude
  end

  # Method to set altitude of the drone.
  def set_altitude
  end

  # Method to get altitude of the drone.
  def get_altitude
  end
end
