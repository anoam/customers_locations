# frozen_string_literal: true

require 'json'
module Infrastructure
  # Storage for customers
  class CustomerRepository

    # Creates repository
    # @param file_name [String] file to load
    # @param customer_factory [#build] factory to build {Domain::Customer}
    # @return [Infrastructure::CustomerRepository]
    # @raise [Domain::InvalidDataError] if given file contains invalid data
    def self.load_file(file_name, customer_factory)
      file_lines = File.readlines(file_name)

      customers = file_lines.map do |line|
        data = JSON.parse(line, symbolize_names: true)
        customer_factory.build(**data)
      end

      new(customers)
    end

    # @param customers [Array<Domain::Customer>]
    def initialize(customers)
      @customers = customers
    end

    # Searches customers who located inside circle with center in `point` and radius `distance`
    # @param point [Domain::Point] center of circle to search customers
    # @param distance [Numeric] radius of circle to search customers
    def near(point, distance)
      customers.find_all { |customer| customer.distance_to(point) <= distance }
    end

    private

    attr_reader :customers
  end
end
