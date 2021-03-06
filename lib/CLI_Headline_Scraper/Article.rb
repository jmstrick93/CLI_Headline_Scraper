class Article

  attr_accessor :network_name, :network, :headline, :url, :authors, :html, :date, :number_of_comments, :summary

  @@all = []

  def initialize(headline, network_name) #headline will eventually be input as a scraper object.
    self.class.all << self
    @network_name = network_name
    @network = Network.find_or_create_by_name(network_name)
    @network.articles << self
     #belongs to network
    @headline = headline
  end

  def self.all
    @@all
  end

  def self.create_with_url(headline, network_name, url)
    article = Article.new(headline, network_name)
    article.url = url
    article
  end


  def self.find_by_headline(headline)
    self.all.detect{|item| item.headline == headline}
  end

  def self.find_by_network_name(network_name)
    self.all.select{|item| item.network_name == network_name}
  end

  def self.find_by_summary(word)

    #cycle through all articles.
    #look at each article's summary
    #if summary contains word, add summary to a new array.
    #after finished with all articles, display array.
    self.all.select { |article| article.summary.downcase.include?(word.downcase) }


  end


  def populate_metadata()
    #retreives metadata of reuters article -- right now just time/date.
    #1. Scrapes data from the selected article's url.(separate)
    #3. Uses that data to populate article.authors, article.date_posted, article.text.
    Scraper.reuters_article(self)
    article = Article.find_by_headline(headline)

  end

end
