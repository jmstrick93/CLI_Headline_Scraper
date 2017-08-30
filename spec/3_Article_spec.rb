require 'spec_helper'

RSpec.describe Article do

  context "Initialization" do

    before(:each){Article.class_variable_set(:@@all, [])}

    it "accepts a @headline and @network_name variable upon initialization" do
      new_article = Article.new("fish are falling from the sky", "CNN")

      new_article_headline = new_article.instance_variable_get(:@headline)
      new_article_network = new_article.instance_variable_get(:@network_name)

      expect(new_article_headline).to eq("fish are falling from the sky")

      expect(new_article_network).to eq("CNN")
    end

    it "is saved to @@all when initialized" do

      new_article = Article.new("fish are falling from the sky", "CNN")
      expect(Article.all).to include(new_article)

    end
  end

  context "custom creation" do

    before(:each){Article.class_variable_set(:@@all, [])}

    describe "#self.create_with_url" do
      it "creates an article with url" do

        article1 = Article.create_with_url("fish are falling from the sky", "CNN", "www.cnn.com/fish_article")

        expect(article1.url).to eq("www.cnn.com/fish_article")

      end

      it "saves to @@all when initialized" do

        new_article = Article.create_with_url("fish are falling from the sky", "CNN", "www.cnn.com/fish_article")
        expect(Article.all).to include(new_article)

      end
    end
  end


  context "finding an article" do
    before(:each){Article.class_variable_set(:@@all, [])}

    describe "#self.find_by_headline" do
      it "returns the article with the headline given as argument" do
        article1 = Article.new("fish are falling from the sky", "CNN")
        article2 = Article.new("bananas are falling from the sky", "CNN")

        found = Article.find_by_headline("bananas are falling from the sky")

        expect(found).to be(article2)

      end

      it "returns nil when there is no article found" do
        article1 = Article.new("fish are falling from the sky", "CNN")
        article2 = Article.new("bananas are falling from the sky", "CNN")

        found = Article.find_by_headline("raindrops are falling from the sky")

        expect(found).to be_nil

      end
    end

    describe "#self.find_by_network_name" do
      it "returns an array of all articles belonging to the network with the given name" do

        cnn = Network.new("CNN")
        fox = Network.new("Fox News")

        article1 = Article.new("fish are falling from the sky", "CNN")
        article2 = Article.new("bananas are falling from the sky", "CNN")
        article3 = Article.new("tubers are falling from the sky", "Fox News")
        article4 = Article.new("coins are falling from the sky", "Fox News")

        found = Article.find_by_network_name("Fox News")
        expect(found).to eq(fox.articles)

      end

      it "returns an empty array when no articles are found" do
        found = Article.find_by_network_name("Hello World")
        expect(found).to eq([])
      end

    end
  end
end
