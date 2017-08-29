class Network

  attr_accessor :headlines, :url
  attr_reader :name

  @@all = []

  def initialize(name)
    @name = name
    @headlines = [] #network has many headlines
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.create_with_url(name, url)
    network = self.new(name)
    network.url = url
    network
  end

  def self.find_by_name(name)
    self.all.detect{|item| item.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.new(name)
  end


  def print_headlines
    self.headlines.each.with_index(1) do |headline, i|
      puts "#{i}. #{headline.text}"
    end
  end


end
