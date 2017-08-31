#will create tests with actual Articles and Networks objects to assist me with making sure the CLI can interact properly with them. Ones with real headlines etc, but non-scraped

require 'spec_helper'

RSpec.describe CLI do

  let!(:cli){CLI.new}

  context 'When selecting only a network' do
    describe '#respond_to_selection' do

      before(:each){Article.class_variable_set(:@@all, [])}
      before(:each){Network.class_variable_set(:@@all, [])}


      it 'opens the network homepage in-browser' do
        cnn = Network.create_with_url("CNN","http://www.cnn.com/")
        article1 = Article.create_with_url("US, South Korea fly bombers over Korean Peninsula", "CNN", "http://www.cnn.com/2017/08/31/politics/us-bombers-korean-peninsula/index.html")
        article2 = Article.create_with_url("Clean water runs out in Beaumont, Texas", "CNN", "http://www.cnn.com/2017/08/31/us/harvey-houston-texas-flood/index.html")

        article3 = Article.create_with_url("Texas Immigration Bill temporarily blocked", "CNN", "http://www.cnn.com/2017/08/30/politics/federal-judge-temporarily-blocks-sb4/index.html")

        expect(Launchy).to receive(:open).with("http://www.cnn.com/")

        cli.respond_to_selection(["CNN"])

      end

    end
  end

  context 'When selecting an article' do
    describe '#article_options_menu' do
      it "offers the user the choice to retrieve article text to display inline"  #if too much, display article metadata instead



      it "offers the user the option to view the article in browser"

      it "lets the user return to previous menu"

      it "lets the user exit"

    end


  end







end
