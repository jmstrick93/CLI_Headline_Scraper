class Network
  attr_accessor :headlines
  attr_reader :name

  @@all = []

  def initialize(name, homepage = nil)
    @name = name
    @headlines = [] #network has many headlines
    self.class.all << self
  end

  def self.all
    @@all
  end


end
