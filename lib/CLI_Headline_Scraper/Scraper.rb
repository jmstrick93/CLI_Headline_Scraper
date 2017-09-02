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

  leader = [html.css("div.primary h1 a").text, html.css("div.primary h1 a").attribute("href").value]
  second = [html.css("div.top-stories a h3").first.text, html.css("div.top-stories li").first.css("a").attribute("href").value]

  third = [html.css("div.top-stories a h3")[1].text, html.css("div.top-stories li[data-vr-contentbox = ''] a")[4].attribute("href").value]

  articles = [leader, second, third]

end

def self.fox_article(article)
  article.html = self.get_page(article.url)
  article.summary = article.html.css("meta[name='description']").attribute("content").value
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
        article[1] = "www.msnbc.com" + article[1]
      end
    end
  end


#<<<<<<<<<<<<<<<<<<< CNN SCRAPING METHODS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  def self.cnn_homepage
    url = "http://www.cnn.com"
    homepage = self.get_page(url)
    cnn = Network.create_with_url("CNN", url)
    cnn.home_html = homepage
    self.scrape_cnn_articles

    #code retrieving top 3 articles of day in 2-layer nested array.
    #e.g. [["headline", "url"], [headline, url], [headline, url]]
  end

  def self.scrape_cnn_articles

    #returns an array of 3 articles with their headlines and homepages

    #leader_headline: <h2 class="banner-text screaming-banner-text banner-text-size--char-44" data-analytics="_list-hierarchical-xs_article_">Hurricane Irma could be the next disaster</h2>
    html = Network.find_by_name("CNN").home_html
    leader = html.css(".banner-text").text

    # secondary headline: <div class="cd__content"><h3 class="cd__headline" data-analytics="Other top stories_list-hierarchical-xs_article_"><a href="/2017/08/31/politics/sheriff-david-clarke-resignation/index.html"><span class="cd__headline-text"><strong>Milwaukee sheriff, whose book Trump just promoted<strong></strong>, resigns</strong></span><span class="cd__headline-icon"></span></a></h3></div>

    # third headline: <article class="cd cd--card cd--hyperlink cd--idx-1 cd--extra-small cd--has-siblings cd--media__image" data-vr-contentbox="http://money.cnn.com/2017/09/01/news/economy/august-jobs-report/index.html" data-eq-pts="xsmall: 0, small: 300, medium: 460, large: 780, full16x9: 1100" data-eq-state="xsmall small"><div class="cd__wrapper" data-analytics="Other top stories_list-hierarchical-xs_hyperlink_"><div class="cd__content"><h3 class="cd__headline" data-analytics="Other top stories_list-hierarchical-xs_hyperlink_"><a href="http://money.cnn.com/2017/09/01/news/economy/august-jobs-report/index.html"><span class="cd__headline-text">Job growth slows in August</span><span class="cd__headline-icon"></span></a></h3></div></div></article>


  end


  def self.cnn_article
  end

end
