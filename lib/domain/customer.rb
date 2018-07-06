# frozen_string_literal: true

module Domain
  # Our dear customer
  class Customer

    attr_reader :name, :user_id

    # @param user_id [Integer] customer's user ID
    # @param name [String] customer's name
    # @param location [#dstance_to] customer's position
    def initialize(user_id:, name:, location:)
      @user_id = user_id
      @name = name
      @location = location
    end

    # String representation
    # @return [String] Customer's name + user ID
    def to_s
      "#{name} (#{user_id})"
    end

    # Calculate distance to given location
    # @param point [#latitude, #longitude] position to find distance to
    # @return [Numeric] distance to given location in kilometers
    def distance_to(point)
      location.distance_to(point)
    end

    private

    attr_reader :location
  end
end
