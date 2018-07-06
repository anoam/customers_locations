# frozen_string_literal: true

# Business rules
module Domain
  autoload :InvalidDataError, "domain/invalid_data_error"
  autoload :Point, "domain/point"
  autoload :Customer, "domain/customer"
  autoload :CustomerFactory, "domain/customer_factory"
end
