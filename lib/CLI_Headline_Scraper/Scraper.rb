class Scraper
binding.pry

  def self.get_page(url)
    doc = Nokogiri::HTML(open(url))
  end


  def self.cnn_homepage
    homepage = self.get_page("www.cnn.com")

    #code retrieving top 3 articles of day in 2-layer nested array.
    #e.g. [["headline", "url"], [headline, url], [headline, url]]


  end

  def self.create_Articles_from_homepage
    #to go inside the
  end


  def self.cnn_article
  end


end
