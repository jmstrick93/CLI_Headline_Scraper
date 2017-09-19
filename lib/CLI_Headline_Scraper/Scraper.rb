class Scraper

  def self.get_page(url)
    doc = Nokogiri::HTML(open(url))
  end

#<<<<<<<<<<<<<<<<<<REUTERS SCRAPING METHODS>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

def self.reuters_homepage

  url = "https://www.reuters.com"
  homepage = self.get_page(url)
  reuters = Network.create_with_url("REUTERS", url)
  reuters.home_html = homepage
  self.scrape_reuters_articles.each{|article| article = Article.create_with_url(article[0],"REUTERS", article[1])}

end


def self.scrape_reuters_articles

  html = Network.find_by_name("REUTERS").home_html
  leader = [html.css("section.right-now-module h2.story-title a").text, html.css("section.right-now-module h2.story-title a").attribute("href").value]
  second = [html.css("section#hp-top-news-top article.story div.story-content a h3.story-title").first.text.strip, html.css("section#hp-top-news-top article.story div.story-content a").first.attribute("href").value]
  third = [html.css("section#hp-top-news-top article.story div.story-content a h3.story-title")[1].text.strip, html.css("section#hp-top-news-top article.story div.story-content a")[1].attribute("href").value]
  articles = [leader, second, third]

  self.check_reuters_urls(articles)

  articles

end


def self.check_reuters_urls(articles)
   #checks for and corrects common issue where MSNBC uses partial urls for internal links

  articles.each do |article|
    if !article[1].include?("www")
      article[1] = "https://www.reuters.com" + article[1]
    end
  end
end

def self.reuters_article(article)

  article.html = self.get_page(article.url)
  article.summary = article.html.css("meta[name='description']").attribute("content").value

  article.date = article.html.css("meta[name='REVISION_DATE']").attribute("content").value

  # article.authors = article.html.css("meta[name='Author']").attribute("content").value

end




#<<<<<<<<<<<<<<<<<<FOX SCRAPING METHODS>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

def self.fox_homepage
  url = "http://www.foxnews.com"
  homepage = self.get_page(url)
  fox = Network.create_with_url("FOX NEWS", url)
  fox.home_html = homepage
  self.scrape_fox_articles.each{|article| article = Article.create_with_url(article[0],"FOX NEWS", article[1])}

end

def self.scrape_fox_articles

  html = Network.find_by_name("FOX NEWS").home_html
    leader = [html.css("div.collection.collection-spotlight article.article.story-1 header a").text.strip, html.css("div.collection.collection-spotlight article.article.story-1 header a").attribute("href")]

    second = [html.css("div.main.main-secondary article.article.story-1 h2.title a").text, html.css("div.main.main-secondary article.article.story-1 h2.title a").attribute("href").value]

    third = [html.css("div.main.main-secondary article.article.story-2 h2.title a").text, html.css("div.main.main-secondary article.article.story-2 h2.title a").attribute("href").value]

  articles = [leader, second, third]

end


def self.fox_article(article)
  article.html = self.get_page(article.url)
  article.summary = article.html.css("meta[name='description']").attribute("content").value

  article.date = article.html.css("meta[name='dc.date']").attribute("content").value

end


#<<<<<<<<<<<<<<<MSNBC SCRAPING METHODS>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  def self.msnbc_homepage
    url = "http://www.msnbc.com"
    homepage = self.get_page(url)
    msnbc = Network.create_with_url("MSNBC", url)
    msnbc.home_html = homepage
    self.scrape_msnbc_articles.each{|article| article = Article.create_with_url(article[0],"MSNBC", article[1])}

  end

  def self.scrape_msnbc_articles

    html = Network.find_by_name("MSNBC").home_html
    leader = [html.css("a[data-fragment = '#homepage-item-1'] span.featured-slider-menu__item__link__title").text, html.css("a[data-fragment = '#homepage-item-1']").attribute("href").value]
    second = [html.css("a[data-fragment = '#homepage-item-2'] span.featured-slider-menu__item__link__title").text, html.css("a[data-fragment = '#homepage-item-2']").attribute("href").value]
    third = [html.css("a[data-fragment = '#homepage-item-3'] span.featured-slider-menu__item__link__title").text, html.css("a[data-fragment = '#homepage-item-3']").attribute("href").value]

    articles = [leader, second, third]
    self.check_msnbc_urls(articles)

    articles
  end

  def self.check_msnbc_urls(articles)
     #checks for and corrects common issue where MSNBC uses partial urls for internal links

    articles.each do |article|
      if !article[1].include?("www")
        article[1] = "http://www.msnbc.com" + article[1]
      end
    end
  end

  def self.msnbc_article(article)

    article.html = self.get_page(article.url)
    article.summary = article.html.css("meta[name='description']").attribute("content").value

   if !!article.html.css("meta[property='nv:date']")[0]
     article.date = article.html.css("meta[property='nv:date']").attribute("content").value
   else
     article.date = article.html.css("meta[name = 'DC.date.issued']").attribute("content").value
   end

  end


end
