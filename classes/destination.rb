class Destination
	attr_reader :name, :address, :status

	def initialize(name, address)
		@name = name
		@address = address
	end
end