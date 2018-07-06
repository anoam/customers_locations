# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require "domain"
require "infrastructure"

def init_repository(file_name)
  factory = Domain::CustomerFactory.new
  Infrastructure::CustomerRepository.load_file(file_name, factory)
end