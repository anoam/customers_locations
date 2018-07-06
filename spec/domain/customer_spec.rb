require "domain"

RSpec.describe Domain::Customer do
  let(:frank_location) { instance_double(Domain::Point, distance_to: 42) }
  let(:christina_location) { instance_double(Domain::Point, distance_to: 9000) }

  let(:frank) { Domain::Customer.new(user_id: 7, location: frank_location, name: "Frank Kehoe") }
  let(:christina) { Domain::Customer.new(user_id: 12, location: christina_location, name: "Christina McArdle") }

  describe "#to_s" do
    it { expect(frank.to_s).to eq("Frank Kehoe (7)") }
    it { expect(christina.to_s).to eq("Christina McArdle (12)") }
  end

  describe "#distance_to" do
    let(:office_location) { double(:point) }

    it "checks distance for Frank" do
      expect(frank_location).to receive(:distance_to).with(office_location)
      distance = frank.distance_to(office_location)

      expect(distance).to eql(42)
    end

    it "checks distance for Christina" do
      expect(christina_location).to receive(:distance_to).with(office_location)
      distance = christina.distance_to(office_location)

      expect(distance).to eql(9000)
    end

  end
end
