class Scraper

  def self.get_page(url)
    doc = Nokogiri::HTML(open(url))
  end


  def self.cnn_homepage
    url = "http://www.cnn.com"
    homepage = self.get_page(url)
    cnn = Network.create_with_url("CNN", url)
    cnn.home_html = homepage



    #code retrieving top 3 articles of day in 2-layer nested array.
    #e.g. [["headline", "url"], [headline, url], [headline, url]]
  end

  def self.create_Articles_from_homepage
    #to go inside #self.cnn_homepage.
    #
  end


  def self.cnn_article
  end


end
