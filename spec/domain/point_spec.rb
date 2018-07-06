require "domain"

RSpec.describe Domain::Point do
  describe "instance methods" do
    let(:office) { Domain::Point.new(latitude: 53.339428, longitude: -6.257664) }
    let(:christina) { Domain::Point.new(latitude: 52.986375, longitude: -6.043701) }

    describe "#coordinates" do
      it { expect(office.latitude).to eq(53.339428) }
      it { expect(office.longitude).to eq(-6.257664) }

      it { expect(christina.latitude).to eq(52.986375) }
      it { expect(christina.longitude).to eq(-6.043701) }
    end

    describe "#distance_to" do
      let(:alice) { Domain::Point.new(latitude: 51.92893, longitude: -10.27699) }

      it { expect(office.distance_to(christina).round).to eql(42) }
      it { expect(christina.distance_to(office).round).to eql(42) }

      it { expect(alice.distance_to(office).round).to eql(313) }
      it { expect(alice.distance_to(christina).round).to eql(310) }
    end
  end

  describe ".build" do
    subject { Domain::Point }

    context "when params valid" do
      it "builds point" do
        built = subject.build(latitude: 55.75, longitude: 37.61)
        expect(built).to be_a(Domain::Point)
        expect(built.latitude).to eql(55.75)
        expect(built.longitude).to eql(37.61)
      end
    end

    context "when params invalid" do

      it "raises error on non-numeric latitude" do
        expect { subject.build(latitude: "invalid", longitude: 37.61) }.to raise_exception(Domain::InvalidDataError)
        expect { subject.build(latitude: nil, longitude: 37.61) }.to raise_exception(Domain::InvalidDataError)
      end

      it "raises error on non-numeric longitude" do
        expect { subject.build(latitude: 55.75, longitude: "invalid") }.to raise_exception(Domain::InvalidDataError)
        expect { subject.build(latitude: 55.75, longitude: nil) }.to raise_exception(Domain::InvalidDataError)
      end

      it "raises error on invalid latitude" do
        expect {subject.build(latitude: -91, longitude: 37.61) }.to raise_exception(Domain::InvalidDataError)
        expect { subject.build(latitude: 90.01, longitude: 37.61) }.to raise_exception(Domain::InvalidDataError)
      end

      it "throws on invalid longitude" do
        expect { subject.build(latitude: 55.75, longitude: -181) }.to raise_exception(Domain::InvalidDataError)
        expect { subject.build(latitude: 55.75, longitude: 180.1) }.to raise_exception(Domain::InvalidDataError)
      end

    end
  end

end
