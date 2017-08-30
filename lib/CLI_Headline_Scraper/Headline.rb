class Article

  attr_accessor :network_name, :network, :headline, :url

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

end
