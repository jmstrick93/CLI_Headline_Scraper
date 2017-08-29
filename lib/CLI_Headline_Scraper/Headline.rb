class Headline
  @text
  @@all = []

  def initialize(network, text) #text will be input as a scraper object.
    @network = network
    self.all << self
    network.headlines << self #belongs to network
    @text = text
  end

  def self.all
    @@all
  end

end
