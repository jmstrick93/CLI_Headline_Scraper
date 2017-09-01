#will create tests with actual Articles and Networks objects to assist me with making sure the CLI can interact properly with them. Ones with real headlines etc, but non-scraped

require 'spec_helper'

RSpec.describe CLI do

  let!(:cli){CLI.new}

  before(:each){Article.class_variable_set(:@@all, [])}
  before(:each){Network.class_variable_set(:@@all, [])}

  let!(:cnn){Network.create_with_url("CNN","http://www.cnn.com/")}

  let!(:article1){Article.create_with_url("US, South Korea fly bombers over Korean Peninsula", "CNN", "http://www.cnn.com/2017/08/31/politics/us-bombers-korean-peninsula/index.html")}

  let!(:article2){Article.create_with_url("Clean water runs out in Beaumont, Texas", "CNN", "http://www.cnn.com/2017/08/31/us/harvey-houston-texas-flood/index.html")}

  let!(:article3){Article.create_with_url("Texas Immigration Bill temporarily blocked", "CNN", "http://www.cnn.com/2017/08/30/politics/federal-judge-temporarily-blocks-sb4/index.html")}



  context 'When selecting only a network' do
    describe '#respond_to_selection' do

      it 'opens the network homepage in-browser' do

        expect(Launchy).to receive(:open).with("http://www.cnn.com/")
        cli.respond_to_selection(["CNN"])

      end

      # it 'selects the right network/article combo' do
      #
      #   allow(cli).to receive(:gets).and_return("CNN:2")
      #   expect($stdout).to receive(:puts).with("Clean water runs out in Beaumont, Texas")
      #   expect($stdout).to receive(:puts).with("CNN")
      #   allow($stdout).to receive(:puts).with("To go to a newtork homepage, just type the name of that network.")
      #   allow($stdout).to receive(:puts).with("To go to a specific story, type the network name and then the article number, separated by a colon (e.g., BBC : 2)")
      #   allow($stdout).to receive(:puts).with("To exit at any time, type 'exit'.")
      #
      #   selection = cli.select_item
      #
      #   cli.respond_to_selection(selection)
      # end
    end
  end

  context 'When selecting an article' do
    describe '#article_options_menu' do
      it "offers the user the choice to retrieve article text or to display inline" do  #if too much, display article metadata instead

        allow($stdout).to receive(:puts).at_least(:once)

        expect($stdout).to receive(:puts).with("What would you like to do? Enter a number.")
        expect($stdout).to receive(:puts).with("1. View article in browser.")
        expect($stdout).to receive(:puts).with("2. Scrape article text to terminal.")

        allow(cli).to receive(:gets).and_return("exit")
        allow(cli).to receive(:exit)

        cli.article_options_menu(article1)
      end

      #the below was commented out because it kept hitting an infinite loop.  REVISIT WITH TUTOR

      # it "lets the user return to previous menu" do
      #   allow(cli).to receive(:gets).and_return("3")
      #
      #   expect(cli).to receive(:puts).at_least(:once)
      #
      #   Timecop.freeze(Time.now) do
      #     expect($stdout).to receive(:puts).with(Time.new)
      #     allow($stdout).to receive(:puts).at_least(:once)
      #     cli.display_menu
      #
      #     expect($stdout).to receive(:puts).with("US, South Korea fly bombers over Korean Peninsula")
      #
      #     expect(cli).to receive(:gets).and_return("exit")
      #
      #     cli.article_options_menu(article1)
      #   end
      #

      # end



      it "lets the user exit" do

        allow(cli).to receive(:gets).and_return("exit")
        expect(cli).to receive(:exit)

        cli.article_options_menu(article1)

      end

    end


  end







end
