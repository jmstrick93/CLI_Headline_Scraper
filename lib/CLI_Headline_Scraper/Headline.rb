class Headline

  @@all = []

  def initialize(network, text)
    @network = network
    self.all << self
  end

  def self.all
    @@all
  end

end
