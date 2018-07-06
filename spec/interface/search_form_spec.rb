require "interface"

RSpec.describe Interface::SearchForm do
  context "when parameters valid" do
    subject { Interface::SearchForm.new(max_distance: "10", latitude: "53.339428", longitude: "-6.257664") }

    it { expect(subject.max_distance).to eq(10) }
    it { expect(subject.latitude).to eq(53.339428) }
    it { expect(subject.longitude).to eq(-6.257664) }
    it { expect(subject.errors).to be_empty }
  end


  context "when parameters invalid" do
    it "requires max_distance" do
      form = Interface::SearchForm.new(max_distance: nil, latitude: "53.339428", longitude: "-6.257664")
      expect(form.valid?).to be_falsey
      expect(form.errors).to include("max distance invalid")
    end

    it "requires max_distance not to be 0" do
      form = Interface::SearchForm.new(max_distance: "0", latitude: "53.339428", longitude: "-6.257664")
      expect(form.valid?).to be_falsey
      expect(form.errors).to include("max distance invalid")
    end

    it "requires max_distance not to be number" do
      form = Interface::SearchForm.new(max_distance: "asd", latitude: "53.339428", longitude: "-6.257664")
      expect(form.valid?).to be_falsey
      expect(form.errors).to include("max distance invalid")
    end

    it "requires latitude" do
      form = Interface::SearchForm.new(max_distance: "10", latitude: nil, longitude: "-6.257664")
      expect(form.valid?).to be_falsey
      expect(form.errors).to include("latitude invalid")
    end

    it "requires latitude not to be 0" do
      form = Interface::SearchForm.new(max_distance: "10", latitude: "0.0", longitude: "-6.257664")
      expect(form.valid?).to be_falsey
      expect(form.errors).to include("latitude invalid")
    end

    it "requires latitude not to be number" do
      form = Interface::SearchForm.new(max_distance: "10", latitude: "asd", longitude: "-6.257664")
      expect(form.valid?).to be_falsey
      expect(form.errors).to include("latitude invalid")
    end

    it "requires longitude" do
      form = Interface::SearchForm.new(max_distance: "10", latitude: "53.339428", longitude: nil)
      expect(form.valid?).to be_falsey
      expect(form.errors).to include("longitude invalid")
    end

    it "requires latitude not to be 0" do
      form = Interface::SearchForm.new(max_distance: "10", latitude: "53.339428", longitude: "0")
      expect(form.valid?).to be_falsey
      expect(form.errors).to include("longitude invalid")
    end

    it "requires latitude not to be number" do
      form = Interface::SearchForm.new(max_distance: "10", latitude: "53.339428", longitude: "erwr")
      expect(form.valid?).to be_falsey
      expect(form.errors).to include("longitude invalid")
    end
  end
end
