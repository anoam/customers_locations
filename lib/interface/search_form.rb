# frozen_string_literal: true

module Interface
  # Form object for search
  class SearchForm

    def initialize(params)
      @distance_param = NumericParametter.new(params[:max_distance])
      @lat_param = NumericParametter.new(params[:latitude])
      @long_param = NumericParametter.new(params[:longitude])
    end

    def valid?
      distance_param.valid? && lat_param.valid? && long_param.valid?
    end

    def max_distance
      distance_param.value
    end

    def latitude
      lat_param.value
    end

    def longitude
      long_param.value
    end

    def errors
      result = []
      result.append("max distance invalid") unless distance_param.valid?
      result.append("latitude invalid") unless lat_param.valid?
      result.append("longitude invalid") unless long_param.valid?

      result
    end

    private

    attr_reader :distance_param, :lat_param, :long_param
  end
end