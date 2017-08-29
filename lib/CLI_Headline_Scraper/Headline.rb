class Headline

  attr_accessor :network, :text, :url

  @@all = []

  def initialize(network, text, url = nil) #text will eventually be input as a scraper object.
    @network = network
    self.class.all << self
    network.headlines << self #belongs to network
    @text = text
  end

  def self.all
    @@all
  end

end
