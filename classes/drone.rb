class Drone
	attr_reader :name, :code, :status, :condition

	def initialize(name, code)
		@name = name
  	@code = code
		@status = "ready"
		@condition = "good"
		# To be implemented in future.
		# @success_rate
	end
end