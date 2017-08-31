require 'spec_helper'

RSpec.describe CLI do

  # before(:each) {Network.class_variable_set(:@@all, [])}
  # before(:each) {Article.class_variable_set(:@@all, [])}

  let!(:cli){CLI.new}
  # let!(:cnn){Network.create_with_url("CNN","http://www.cnn.com/")}
  # let!(:bbc){Network.new("BBC")}
  # let!(:article1){Article.create_with_url("US, South Korea fly bombers over Korean Peninsula", "CNN", "http://www.cnn.com/2017/08/31/politics/us-bombers-korean-peninsula/index.html")}
  # let!(:article2){Article.create_with_url("Clean water runs out in Beaumont, Texas", "CNN", "http://www.cnn.com/2017/08/31/us/harvey-houston-texas-flood/index.html")}
  #
  # let!(:article3){ Article.create_with_url("Texas Immigration Bill temporarily blocked", "CNN", "http://www.cnn.com/2017/08/30/politics/federal-judge-temporarily-blocks-sb4/index.html")}


  it "can be initialized" do
    expect(cli).to be_an_instance_of(CLI)
  end


  describe '#greet' do #call will be the LAST thing tested
    context "When first called:" do
      it "Greets the user and asks them to select from a list of options." do
        allow(cli).to receive(:gets).and_return("exit")
        allow(cli).to receive(:exit)

        expect($stdout).to receive(:puts).with("Welcome to Headline Scraper")
        expect($stdout).to receive(:puts).with("Please select which of the following articles you would like to view:")

        cli.greet
      end
    end

  end

  describe '#exit_CLI' do
    it "says goodbye" do
      allow(cli).to receive(:exit)
      expect($stdout).to receive(:puts).with("Goodbye!")
      cli.exit_CLI
    end

    it "exits the program" do
      allow(cli).to receive(:exit)
      allow($stdout).to receive(:puts)
      expect(cli).to receive(:exit)
      cli.exit_CLI
    end
  end


  describe "#display_menu" do

    after(:each){Article.class_variable_set(:@@all, [])}
    after(:each){Network.class_variable_set(:@@all, [])}

    it "displays the current time" do

      Timecop.freeze(Time.now) do
        expect($stdout).to receive(:puts).with(Time.new)
        allow($stdout).to receive(:puts).at_least(:once)
        cli.display_menu
      end

    end

    it "cleanly displays the headlines for each network in a numbered list" do #this is awful, but I dont know how to clean it up

      article1 = Article.new("fish are falling from the sky", "CNN")
      article2 = Article.new("bananas are falling from the sky", "CNN")
      article3 = Article.new("tubers are falling from the sky", "CNN")
      article4 = Article.new("coins are falling from the sky", "Fox News")
      article5 = Article.new("oranges are falling from the sky", "Fox News")
      article6 = Article.new("apples have become sentient", "Fox News")

      allow($stdout).to receive(:puts).at_least(:once)

      expect($stdout).to receive(:puts).with("CNN")
      expect($stdout).to receive(:puts).with("1. fish are falling from the sky")
      expect($stdout).to receive(:puts).with("2. bananas are falling from the sky")
      expect($stdout).to receive(:puts).with("3. tubers are falling from the sky")
      expect($stdout).to receive(:puts).with("").exactly(3).times

      expect($stdout).to receive(:puts).with("Fox News")
      expect($stdout).to receive(:puts).with("1. coins are falling from the sky")
      expect($stdout).to receive(:puts).with("2. oranges are falling from the sky")
      expect($stdout).to receive(:puts).with("3. apples have become sentient")

      cli.display_menu

    end
  end


  describe '#select_item' do
    context "when first called:" do
      it "describes its functionality to the user" do
        allow(cli).to receive(:exit)
        allow(cli).to receive(:gets).and_return("exit")
        allow($stdout).to receive(:puts).with("Goodbye!")
        allow($stdout).to receive(:puts).with("Selection not found")

        expect($stdout).to receive(:puts).with("To go to a newtork homepage, just type the name of that network.")
        expect($stdout).to receive(:puts).with("To go to a specific story, type the network name and then the article number, separated by a colon (e.g., BBC : 2)")
        expect($stdout).to receive(:puts).with("To exit at any time, type 'exit'.")

        cli.select_item
      end
    end


    context "When given an invalid or nonsensical entry:" do
      it "puts 'Invalid Entry' when given a blank entry." do

        allow($stdout).to receive(:puts).at_least(:once)

        expect(cli).to receive(:gets).and_return("")
        expect($stdout).to receive(:puts).with("Invalid Entry")
        expect(cli).to receive(:gets).and_return('exit')
        expect(cli).to receive(:exit)

        cli.select_item
      end


    it "puts 'Invalid Entry' when given an entry with more than 2 items" do

      allow($stdout).to receive(:puts).with("To go to a newtork homepage, just type the name of that network.")
      allow($stdout).to receive(:puts).with("To go to a specific story, type the network name and then the article number, separated by a colon (e.g., BBC : 2)")
      allow($stdout).to receive(:puts).with("To exit at any time, type 'exit'.")

      expect(cli).to receive(:gets).and_return("BBC : 2 : 3")
      expect($stdout).to receive(:puts).with("Invalid Entry")
      expect($stdout).to receive(:puts).at_least(:once)
      allow(cli).to receive(:gets).and_return('exit')
      allow(cli).to receive(:exit)

      cli.select_item
    end

      it "puts 'Invalid Entry' when the number input is not a number or is a zero" do

        allow($stdout).to receive(:puts).with("To go to a newtork homepage, just type the name of that network.")
        allow($stdout).to receive(:puts).with("To go to a specific story, type the network name and then the article number, separated by a colon (e.g., BBC : 2)")
        allow($stdout).to receive(:puts).with("To exit at any time, type 'exit'.")

        expect(cli).to receive(:gets).and_return("BBC : f")
        expect($stdout).to receive(:puts).with("Invalid Entry")
        expect($stdout).to receive(:puts).at_least(:once)
        allow(cli).to receive(:gets).and_return('exit')
        allow(cli).to receive(:exit)

        cli.select_item
      end


      it "puts 'Invalid Entry' when the number input is greater than three" do #this one works on its own!

        allow($stdout).to receive(:puts).with("To go to a newtork homepage, just type the name of that network.")
        allow($stdout).to receive(:puts).with("To go to a specific story, type the network name and then the article number, separated by a colon (e.g., BBC : 2)")
        allow($stdout).to receive(:puts).with("To exit at any time, type 'exit'.")

        expect(cli).to receive(:gets).and_return("BBC : 4")
        expect($stdout).to receive(:puts).with("Invalid Entry")
        expect($stdout).to receive(:puts).at_least(:once)
        allow(cli).to receive(:gets).and_return('exit')
        allow(cli).to receive(:exit)

        cli.select_item
      end
    end


  context "When input is valid:" do
    it "accepts entries with no article number" do

      allow($stdout).to receive(:puts).at_least(:once)

      expect(cli).to receive(:gets).and_return("BBC")
      expect($stdout).not_to receive(:puts).with("Invalid Entry")
      allow(cli).to receive(:gets).and_return('exit')
      allow(cli).to receive(:exit)

      cli.select_item
    end

    it "accepts entries with article number" do

      allow($stdout).to receive(:puts).at_least(:once)

      expect(cli).to receive(:gets).and_return("Al Jazeera : 2")
      expect($stdout).not_to receive(:puts).with("Invalid Entry")
      allow(cli).to receive(:gets).and_return('exit')
      allow(cli).to receive(:exit)

      cli.select_item
    end
   end
  end
end
