class Headline

  attr_accessor :network_name, :text, :url

  @@all = []

  def initialize(network_name, text, url = nil) #text will eventually be input as a scraper object.
    self.class.all << self
    Network.find_by_name(network_name).headlines << self #belongs to network
    @text = text
  end

  def self.all
    @@all
  end

  def self.create
    

  def self.find_by_text(text)
    self.all.detect{|item| item.text == text}
  end

  def self.find_by_network_name(network_name)
    self.all.select{|item| item.network_name == network_name}
  end

end
