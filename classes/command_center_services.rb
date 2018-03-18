class CommandCenterServices
  attr_accessor :items_array, :active_warehouses, :drone_fleet, :item_code

  def initialize
    @items_array = []
    @active_warehouses = []
    @drone_fleet = []
  end

  def create_items
    (0..2).each do |i|
      puts "\nAdd a new Item :"
      puts "Please enter the name of the item/product"
      name = gets.chomp
      puts "Please enter the item/product code"
      code = gets.chomp
      @items_array << instance_variable_set("@item_obj#{i}", Object.const_get("Item").new(name, code))
      puts "\n================================".yellow
    end
  end

  def create_warehouses
    (0..2).each do |i|
      puts "\nAdd a new warehouse :"
      puts "Please enter the name of the warehouse"
      name = gets.chomp
      puts "Please enter the warehouse code"
      code = gets.chomp
      puts "Please enter the warehouse address"
      address = gets.chomp
      items_hash = {}

      @items_array.each do |item|
        begin
          puts "\nPlease enter the number of available #{item.name} at the WareHouse #{name}"
          @item_count = gets.chomp.to_i
          if @item_count < 1
            puts "\nERROR:Item count should be an integer and cannot be less than 1,
               please enter the count value properly!!!".red
            raise "Invalid input"
          else
            items_hash["#{item.code}"] = {count: @item_count, item: item}
          end
        rescue
          retry
        end
      end

      @active_warehouses << instance_variable_set("@warehouse_obj#{i}", Object.const_get("WareHouse")
                                                  .new(name, code, address, items_hash))
      puts "\n================================".yellow
    end
  end

  def create_drone_fleet
    (0..1).each do |i|
      puts "\nCreate new Drone :"
      puts "Please enter the name of the drone"
      name = gets.chomp
      puts "Please enter the drone code"
      code = gets.chomp
      @drone_fleet << instance_variable_set("@drone_obj#{i}", Object.const_get("Drone").new(name, code))
      puts "\n================================".yellow
    end
  end

  # Method for selecting a drone from a fleet of drones, based on drone status and condtion.
  def select_drone
    @drone_fleet.shuffle.each do |drone|
      return drone if drone.status.eql?('ready') && drone.condition.eql?('good')
    end
  end

  # Method for selecting a warehouse, based on item availability and least active processes.
  def select_warehouse(item_code)
    @active_warehouses.sort! { |a, b|  a.active_processes <=> b.active_processes }
    @active_warehouses.each do |warehouse|
      if warehouse.items_hash[item_code].nil? || warehouse.get_item_count(item_code) < 1
        break
      else
        return warehouse
      end
    end
  end

  # Method for getting a valid item code input.
  def get_item_code
    begin
      puts "\nPlease enter the item code of the item to be delivered"
      @item_code = gets.chomp
      if select_warehouse(@item_code).nil?
        puts "ERROR:Item cannot be found at any WareHouse/Out of stock!!!
        Please try again with a different item code.".red
        raise "no item"
      end
    rescue
      retry
    end
  end
end
