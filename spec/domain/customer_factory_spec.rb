require "domain"

RSpec.describe Domain::CustomerFactory do
  subject { Domain::CustomerFactory.new }

  describe "#build" do
    it "builds customer" do
      customer = subject.build(latitude: "52.986375", user_id: 12, name: "Christina McArdle", longitude: "-6.043701")
      point = Domain::Point.new(latitude: 52.986375, longitude: -6.043701)

      expect(customer).to be_a(Domain::Customer)
      expect(customer.to_s).to be_eql("Christina McArdle (12)")
      expect(customer.name).to be_eql("Christina McArdle")
      expect(customer.distance_to(point)).to be_zero
    end

    it "builds another customer" do
      customer = subject.build(latitude: "53.807778", user_id: 28, name: "Charlie Halligan", longitude: "-7.714444")
      point = Domain::Point.new(latitude: 53.807778, longitude: -7.714444)

      expect(customer).to be_a(Domain::Customer)
      expect(customer.to_s).to be_eql("Charlie Halligan (28)")
      expect(customer.name).to be_eql("Charlie Halligan")
      expect(customer.distance_to(point)).to be_zero
    end

    it "fails on invalid name" do
      expect { subject.build(latitude: "53.807778", user_id: 28, name: "", longitude: "-7.714444") }
        .to raise_error(Domain::InvalidDataError)

      expect { subject.build(latitude: "53.807778", user_id: 28, name: nil, longitude: "-7.714444") }
        .to raise_error(Domain::InvalidDataError)
    end

    it "fails on invalid user ID" do
      expect { subject.build(latitude: "53.807778", user_id: nil, name: "Charlie Halligan", longitude: "-7.714444") }
          .to raise_error(Domain::InvalidDataError)
    end

    it "fails on invalid coordinates" do
      expect { subject.build(latitude: "53.807778", user_id: 28, name: "Charlie Halligan", longitude: "") }
          .to raise_error(Domain::InvalidDataError)

      expect { subject.build(latitude: nil, user_id: 28, name: "Charlie Halligan", longitude: "-7.714444") }
          .to raise_error(Domain::InvalidDataError)
    end
  end
end
