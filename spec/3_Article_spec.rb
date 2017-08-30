require 'spec_helper'

RSpec.describe Article do

  context "Initialization" do

    before(:each){Network.class_variable_set(:@@all, [])}

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
    describe "#self.create_with_url" do

    end
  end


end
