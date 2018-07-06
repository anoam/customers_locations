# frozen_string_literal: true

module Interface
  # Numeric parameter for processing form data
  class NumericParameter
    def initialize(string_value)
      @string_value = string_value
    end

    def value
      string_value.to_f
    end

    def valid?
      return false if string_value.nil?
      return false if string_value.empty?

      !value.zero?
    end

    private

    attr_reader :string_value
  end

  private_constant :NumericParameter
end
