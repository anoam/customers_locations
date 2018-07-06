module Interface
  # Numeric paramter for processing form data
  class NumericParametter

    def initialize(string_value)
      @string_value = string_value
    end

    def value
      return string_value.to_f
    end

    def valid?
      return false if string_value.nil?
      return false if string_value.empty?

      !value.zero?
    end

    private
    attr_reader :string_value

  end

  private_constant :NumericParametter
end