require 'spec_helper'

RSpec.describe CLI do

  let!(:cli){CLI.new}

  it "can be initialized" do
    expect(cli).to be_an_instance_of(CLI)
  end


  describe '#call' do
    context "When first called:" do
      it "Greets the user and asks them to select from a list of options." do
        allow(cli).to receive(:gets).and_return("exit")
        allow(cli).to receive(:exit)

        expect($stdout).to receive(:puts).with("Welcome to Headline Scraper")
        expect($stdout).to receive(:puts).with("Please select which of the following headlines you would like to view:")
        expect($stdout).to receive(:puts).at_least(:once)

        cli.call
      end
    end
    # context "When entry is invalid or nonsensical:" do
    #   it ""
    # end
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


  describe '#select_item' do
    context "when first called:" do
      it "describes its functionality to the user" do
        allow(cli).to receive(:exit)
        allow(cli).to receive(:gets).and_return("exit")
        allow($stdout).to receive(:puts).with("Goodbye!")

        expect($stdout).to receive(:puts).with("To go to a newtork homepage, just type the name of that network.")
        expect($stdout).to receive(:puts).with("To go to a specific story, type the network name and then the article number, separated by a colon (e.g., BBC : 2)")
        expect($stdout).to receive(:puts).with("To exit at any time, type 'exit'.")

        cli.select_item
      end
    end

    context "When given an invalid or nonsensical entry:" do
    it "puts 'Invalid Entry' when given a blank entry." do

      allow($stdout).to receive(:puts).with("To go to a newtork homepage, just type the name of that network.")
      allow($stdout).to receive(:puts).with("To go to a specific story, type the network name and then the article number, separated by a colon (e.g., BBC : 2)")
      allow($stdout).to receive(:puts).with("To exit at any time, type 'exit'.")

      expect(cli).to receive(:gets).and_return("")
      expect($stdout).to receive(:puts).with("Invalid Entry")
      expect($stdout).to receive(:puts).at_least(:once)
      allow(cli).to receive(:gets).and_return('exit')
      allow(cli).to receive(:exit)

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

      it "puts 'Invalid Entry' when the number input is greater than three" do

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
    end

  end

end
