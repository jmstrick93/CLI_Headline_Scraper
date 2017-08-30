require 'spec_helper'

RSpec.describe Network do
  let!(:bbc){Network.new("BBC")}
  let!(:cnn){Network.new("CNN")}

  context "Initialization" do

    it "accepts a @name variable upon initialization" do
      new_network = Network.new("Al-Arabiya")
      new_network_name = new_network.instance_variable_get(:@name)
      expect(new_network_name).to eq("Al-Arabiya")
    end

    it "is saved to @@all when initialized" do

      new_network = Network.new("Al-Arabiya")
      expect(Network.all).to include(new_network)

    end

  end

  context "Relationships" do

    before(:each) do
      @@all = []
    end

    describe "#self.all" do
      it "returns the class variable @@all" do
        expect(Network.all).to match_array([])

        Network.class_variable_set(:@@all, [bbc])

        expect(Network.all).to match_array([bbc])
      end

    end
  end

  context "Methods" do

    before(:each) do
      @@all = []
    end


    describe "#self.create_with_url" do
      it "creates a network with an included homepage URL" do

          new_network = Network.create_with_url("Al-Arabiya", "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjbrbuh9f7VAhWK5SYKHYdmAzgQFggoMAA&url=https%3A%2F%2Fenglish.alarabiya.net%2F&usg=AFQjCNHHgd8PqaCna9geb3R3dF2ai_3D5Q")

          expect(Network.all).to include(new_network)
          expect(new_network.url).to eq("https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjbrbuh9f7VAhWK5SYKHYdmAzgQFggoMAA&url=https%3A%2F%2Fenglish.alarabiya.net%2F&usg=AFQjCNHHgd8PqaCna9geb3R3dF2ai_3D5Q")
      end
    end


    describe "#self.find_by_name" do

      it "returns nil if the network does not exist" do
        arabiya = Network.new("Al-Arabiya")
        cnn = Network.new("CNN")
        expect(Network.find_by_name("Fox News")).to be_nil
      end

      it "returns the network with the matching name if it does exist" do
        binding.pry
        expect Network.find_by_name("CNN").to eq()

      end
    end

  end

end
