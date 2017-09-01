class Network

  attr_accessor :articles, :url, :home_html
  attr_reader :name

  @@all = []

  def initialize(name)
    @name = name
    @articles = [] #network has many articles
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
    self.articles.each.with_index(1) do |article, i|
      puts "#{i}. #{article.headline}"
    end
  end


  def go_to_homepage
    Launchy.open(self.url)
  end



end
