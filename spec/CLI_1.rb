require 'spec_helper'

RSpec.describe CLI do

  let!(:cli){CLI.new}

  it "can be initialized" do
    expect(cli).to be_an_instance_of(CLI)
  end

  describe '#call' do
    it "Greets the user and asks them to select from a list of options." do
      expect(cli.call).to output.to_stdout
    end
  end
end
