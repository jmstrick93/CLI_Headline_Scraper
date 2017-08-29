class Network
  attr_accessor :headlines
  attr_reader :name
  @@all = []

  def initialize(name)
    @name = name
    @headlines = []
    self.all << self
  end

  def self.all
    @@all
  end


end
