# frozen_string_literal: true

module Domain
  # Provides new customers initialization
  class CustomerFactory
    # Builds new instance of {Domain::Customer}
    # @param latitude [String] geo latitude
    # @param longitude [String] geo longitude
    # @param user_id [Integer] customer's user ID
    # @param name [String] customer's name
    def build(user_id:, name:, latitude:, longitude:)
      raise(InvalidDataError, "user_id is invalid") if user_id.nil?
      raise(InvalidDataError, "name is invalid") if name.nil? || name.empty?

      location = build_point(latitude, longitude)
      Customer.new(user_id: user_id, name: name, location: location)
    end

    private

    def build_point(latitude, longitude)
      raise(InvalidDataError, "latitude is invalid") if latitude.nil? || latitude.empty?
      raise(InvalidDataError, "longitude is invalid") if longitude.nil? || longitude.empty?

      Point.build(latitude: latitude.to_f, longitude: longitude.to_f)
    end
  end
end