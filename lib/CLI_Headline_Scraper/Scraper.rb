class Scraper

  def self.get_page(url)
    doc = Nokogiri::HTML(open(url))
  end


  def self.cnn_homepage
    url = "http://www.cnn.com"
    homepage = self.get_page(url)
    cnn = Network.create_with_url("CNN", url)
    cnn.home_html = homepage
    binding.pry
    self.scrape_cnn_articles

    #code retrieving top 3 articles of day in 2-layer nested array.
    #e.g. [["headline", "url"], [headline, url], [headline, url]]
  end



  def self.msnbc_homepage
    url = "http://www.msnbc.com"
    homepage = self.get_page(url)
    msnbc = Network.create_with_url("MSNBC", url)
    msnbc.home_html = homepage
    binding.pry
    self.scrape_msnbc_articles
  end

  def self.scrape_msnbc_articles

    #<span class="featured-slider-menu__item__link__title" data-dy-title="">Kushner divestment claims draw scrutiny – again</span>

    html = Network.find_by_name("MSNBC").home_html

    leader = [html.css("a[data-fragment = '#homepage-item-1'] span.featured-slider-menu__item__link__title").text, html.css("a[data-fragment = '#homepage-item-1']").attribute("href").value]



    binding.pry
  end

  def self.scrape_cnn_articles

    #returns an array of 3 articles with their headlines and homepages

    #leader_headline: <h2 class="banner-text screaming-banner-text banner-text-size--char-44" data-analytics="_list-hierarchical-xs_article_">Hurricane Irma could be the next disaster</h2>
    html = Network.find_by_name("CNN").home_html
    binding.pry
    leader = html.css(".banner-text").text

    # secondary headline: <div class="cd__content"><h3 class="cd__headline" data-analytics="Other top stories_list-hierarchical-xs_article_"><a href="/2017/08/31/politics/sheriff-david-clarke-resignation/index.html"><span class="cd__headline-text"><strong>Milwaukee sheriff, whose book Trump just promoted<strong></strong>, resigns</strong></span><span class="cd__headline-icon"></span></a></h3></div>

    # third headline: <article class="cd cd--card cd--hyperlink cd--idx-1 cd--extra-small cd--has-siblings cd--media__image" data-vr-contentbox="http://money.cnn.com/2017/09/01/news/economy/august-jobs-report/index.html" data-eq-pts="xsmall: 0, small: 300, medium: 460, large: 780, full16x9: 1100" data-eq-state="xsmall small"><div class="cd__wrapper" data-analytics="Other top stories_list-hierarchical-xs_hyperlink_"><div class="cd__content"><h3 class="cd__headline" data-analytics="Other top stories_list-hierarchical-xs_hyperlink_"><a href="http://money.cnn.com/2017/09/01/news/economy/august-jobs-report/index.html"><span class="cd__headline-text">Job growth slows in August</span><span class="cd__headline-icon"></span></a></h3></div></div></article>


  end

  def self.create_Articles_from_homepage
    #will I need this?
    #
  end


  def self.cnn_article
  end


end
