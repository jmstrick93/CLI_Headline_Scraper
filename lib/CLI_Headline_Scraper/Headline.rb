class Headline

  attr_accessor :network_name, :network, :text, :url

  @@all = []

  def initialize(network_name, text) #text will eventually be input as a scraper object.
    self.class.all << self
    @network_name = network_name
    @network = Network.find_or_create_by_name(network_name)
    @network.headlines << self
     #belongs to network
    @text = text
  end

  def self.all
    @@all
  end

  def create_with_url
  end


  def self.find_by_text(text)
    self.all.detect{|item| item.text == text}
  end

  def self.find_by_network_name(network_name)
    self.all.select{|item| item.network_name == network_name}
  end

end
