# frozen_string_literal: true

module Interface
  # Form object for search
  class SearchForm
    # @param params [Hash<Symbol => String>] raw parameters
    def initialize(params)
      @distance_param = NumericParameter.new(params[:max_distance])
      @lat_param = NumericParameter.new(params[:latitude])
      @long_param = NumericParameter.new(params[:longitude])
    end

    # Checks if form parameters was valid
    def valid?
      distance_param.valid? && lat_param.valid? && long_param.valid?
    end

    # @return [Numeric] max distance specified by user
    def max_distance
      distance_param.value
    end

    # @return [Numeric] latitude specified by user
    def latitude
      lat_param.value
    end

    # @return [Numeric] longitude specified by user
    def longitude
      long_param.value
    end

    # @return [Array<String>] errors found in specified by user parameters. empty if no errors found
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
