# frozen_string_literal: true

require_relative "init"
require "sinatra"

data_file_name = ARGV[0] || "data/customers.txt"

repository = init_repository(data_file_name)

get "/" do
  erb :index
end

get "/find" do

end