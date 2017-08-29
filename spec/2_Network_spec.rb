require 'spec_helper'

RSpec.describe Network do
  let!(:bbc){Network.new("BBC")}
  let!(:cnn){Network.new("CNN")}

  context "Initialization" do

    it "accepts a @name variable upon initialization" do
      new_network = Network.new("Al-Arabia")
      new_network_name = new_network.instance_variable_get(:@name)
      expect(new_network_name).to eq("Al-Arabia")
    end

    it "is saved to @@all when initialized" do
      expect(@@all).to include

    end

    it "cannot have its name variable changed" do

    end

  end

  context "Relationships" do
    describe "#self.all" do
      it "is a class method that returns a list of all existing networks" do
        it "returns the class variable @@all" do
          expect(Network.all).to match_array([])

          Network.class_variable_set(:@@all, [network1])

          expect(Network.all).to match_array([network1])
        end
      end

    end
  end

end
