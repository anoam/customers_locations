# frozen_string_literal: true

module Domain
  # Geo-point
  class Point
    RAD_PER_DEG = Math::PI / 180
    EARTH_RADIUS = 6_371 # in kilometers

    attr_reader :latitude, :longitude

    # Check arguments and creates new instance
    # @param latitude [Numerical] geo latitude
    # @param longitude [Numerical] geo longitude
    # @return [Point]
    # @raise [InvalidDataError] if parameters invalid
    def self.build(latitude:, longitude:)
      raise(InvalidDataError, "Invalid latitude") unless latitude.is_a?(Numeric)
      raise(InvalidDataError, "Invalid longitude") unless longitude.is_a?(Numeric)
      raise(InvalidDataError, "Invalid latitude") unless latitude.between?(-90, 90)
      raise(InvalidDataError, "Invalid longitude") unless longitude.between?(-180, 180)

      new(latitude: latitude, longitude: longitude)
    end

    # @param latitude [Numerical] geo latitude
    # @param longitude [Numerical] geo longitude
    def initialize(latitude:, longitude:)
      @latitude = latitude
      @longitude = longitude
    end

    # rubocop:disable Metrics/AbcSize
    # Calculates distance to other point in kilometers
    # @param other [#latitude, #longitude]
    # @return [Numeric] distance in kilometers
    def distance_to(other)
      latitude_rad = to_rad(latitude)
      longitude_rad = to_rad(longitude)

      other_latitude_rad = other.latitude * RAD_PER_DEG
      other_longitude_rad = other.longitude * RAD_PER_DEG

      # Deltas, converted to rad
      delta_longitude_rad = longitude_rad - other_longitude_rad
      delta_latitude_rad = latitude_rad - other_latitude_rad

      distance_rad = Math.sin(delta_latitude_rad / 2)**2 +
                     Math.cos(latitude_rad) * Math.cos(other_latitude_rad) * Math.sin(delta_longitude_rad / 2)**2

      2 * Math.asin(Math.sqrt(distance_rad)) * EARTH_RADIUS
    end

    # rubocop:enable Metrics/AbcSize

    private

    def to_rad(val)
      val * RAD_PER_DEG
    end
  end
end
