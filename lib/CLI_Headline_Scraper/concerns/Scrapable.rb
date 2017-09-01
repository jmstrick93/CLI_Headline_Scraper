module Scraper

  def get_page(url)
    doc = Nokogiri::HTML(open(url))
  end

end
