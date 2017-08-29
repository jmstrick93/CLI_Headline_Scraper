require 'spec_helper'

RSpec.describe CLIHeadlineScraper::CLI do

  let!(:cli){CLIHeadlineScraper::CLI.new}

  it "can be initialized" do
    expect(cli).to be_an_instance_of(CLIHeadlineScraper::CLI)
  end

  describe '#call' do
    it "Greets the user and asks them to select from a list of options." do
      expect(cli.call).to output.to_stdout
    end
  end
end
