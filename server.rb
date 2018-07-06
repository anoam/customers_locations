# frozen_string_literal: true

require_relative "init"
require "sinatra"
require "interface"

data_file_name = ARGV[0] || "data/customers.txt"

repository = init_repository(data_file_name)

get "/" do
  erb :index
end

get "/find" do
  form = Interface::SearchForm.new(params)

  return form.errors.join("<br />") unless form.valid?

  location = Domain::Point.build(latitude: form.latitude, longitude: form.longitude)

  repository.near(location, form.max_distance).join("<br />")
rescue Domain::InvalidDataError => e
  e.message
end
