require "domain"
require "infrastructure"

RSpec.describe Infrastructure::CustomerRepository do
  let(:customer_factory) {instance_double(Domain::CustomerFactory)}

  let(:customer1) { instance_double(Domain::Customer, distance_to: 100, user_id: 3) }
  let(:customer2) { instance_double(Domain::Customer, distance_to: 20, user_id: 1) }
  let(:customer3) { instance_double(Domain::Customer, distance_to: 99, user_id: 2) }

  let(:office_point) {instance_double(Domain::Point)}

  before do
    allow(customer_factory).to receive(:build).with({user_id: 3, name: "Christina", latitude: "1", longitude: "1"}).and_return(customer1)
    allow(customer_factory).to receive(:build).with({user_id: 1, name: "Ian", latitude: "2", longitude: "2"}).and_return(customer2)
    allow(customer_factory).to receive(:build).with({user_id: 2, name: "Jack", latitude: "3", longitude: "3"}).and_return(customer3)
  end

  it "builds repository using file" do
    repository = Infrastructure::CustomerRepository.load_file("spec/test_data/stub.txt", customer_factory)
    expect(repository).to be_a(Infrastructure::CustomerRepository)

    found_customers = repository.near(office_point, 100)

    expect(found_customers).to be_a(Array)
    expect(found_customers.size).to eql(3)
    expect(found_customers).to include(customer1)
    expect(found_customers).to include(customer2)
    expect(found_customers).to include(customer3)
  end

  it "raises error on invalid data" do
    allow(customer_factory).to receive(:build).with({user_id: 1, name: "Ian", latitude: "2", longitude: "2"})
                                   .and_raise(Domain::InvalidDataError)

    expect {Infrastructure::CustomerRepository.load_file("spec/test_data/stub.txt", customer_factory)}
        .to raise_error(Domain::InvalidDataError)
  end

  it "finds only customers who located closer than required distance" do
    allow(customer3).to receive(:distance_to).with(office_point).and_return(200)

    repository = Infrastructure::CustomerRepository.new([customer1, customer2, customer3])

    found_customers = repository.near(office_point, 100)

    expect(found_customers.size).to eql(2)
    expect(found_customers).to include(customer1)
    expect(found_customers).to include(customer2)
  end

  it "sorts customers by userid asc" do
    repository = Infrastructure::CustomerRepository.load_file("spec/test_data/stub.txt", customer_factory)

    found_customers = repository.near(office_point, 100)

    expect(found_customers.first).to eql(customer2)
    expect(found_customers[1]).to eql(customer3)
    expect(found_customers[2]).to eql(customer1)
  end
end
