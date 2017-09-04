#Our CLI Controller
class CLI

  attr_reader :time
  attr_accessor :current_item

  def initialize
  end

  def call

    self.greet
    self.display_menu #initial menu selection of what you want to see
    self.respond_to_selection(self.select_item)

  end

  def greet
    puts "Welcome to Headline Scraper"
    puts "Please select which of the following articles you would like to view:"
  end

  def display_menu
    self.class.display_time
    puts ""
    self.print_group_headlines
  end


  def print_group_headlines
    Network.all.each do |network|
      puts network.name #prints network name once
      network.print_headlines # prints network headlines in numbered list
      puts "" #for spacing
    end
  end

  def valid_selection?(selection) #pre-screens nonsensical entries. DOES NOT check whether the item entered exists
    if selection == nil #
      false
    elsif selection.length == 0
      false
    elsif selection.length == 1
      if selection[0].to_i != 0 #makes furst first item isnt Integer
        false
      else
        true
      end
    elsif selection.length == 2
      if selection[0].to_i != 0 #makes sure first item isnt Integer
        false
      else
        if selection[1].to_i == 0 #makes sure second item IS integer
          false
        elsif selection[1].to_i > 3 #makes sure there are not >3 entries
          false
        else
          true
        end
      end
    elsif selection.length > 2 #makes sure entry isnt longer than 3
      false
    else
      true
    end
  end


  def select_item #returns an array where arr[0] is the network name and arr[1] is the article number.
    #currently accepts all entries that do not contain a colon.  Later make it so it checks whether the network entered exists.
    selection = nil
    until selection_exists?(selection) || selection == 'EXIT'
      puts "To go to a network homepage, just type the name of that network."
      puts "To go to a specific story, type the network name and then the article number, separated by a colon (e.g., BBC : 2)"
      puts "To exit at any time, type 'exit'."

      selection = gets.strip
      selection = selection.split(":") if selection != nil #turns the entered data into an array so ti can be processed
      if valid_selection?(selection)
        binding.pry
        selection[0].strip!
        selection[0] = selection[0].upcase
        if selection.length == 1
          if selection[0] == 'EXIT'
            self.exit_CLI
          end
        elsif selection.length == 2
          selection[1].strip!
          selection[1] = selection[1].to_i
        end

        if !selection_exists?(selection)
          puts "Selection not found"
        end
      else
        puts "Invalid Entry"
      end

    end
    selection
  end

  def exit_CLI
    puts "Goodbye!"
    exit
  end

  def respond_to_selection(selection)
      if selection.length == 1
        the_network = Network.find_by_name(selection[0])
        the_network.go_to_homepage
      elsif selection.length == 2
        the_network = Network.find_by_name(selection[0])
        the_article = the_network.articles[selection[1]-1]
        self.article_options_menu(the_article)
      end


  end

  def selection_exists?(selection) #post-screens entries to make sure the valid entry actually refers to an existing item
    if self.valid_selection?(selection)
      if selection.length == 1
        if Network.find_by_name(selection[0])
          true
        else
          false
        end
      elsif selection.length == 2
        if Network.find_by_name(selection[0])
          if selection[1] > Network.find_by_name(selection[0]).articles.length || selection[1] <= 0
            false
          else
            true
          end
        else
          false
        end
      end
    else
      false
    end
  end



  def select_scrape_method(article)

    case article.network_name

    when "REUTERS"
      Scraper.reuters_article(article)
    when "FOX NEWS"
      Scraper.fox_article(article)
    when "MSNBC"
      Scraper.msnbc_article(article)
    end
  end






  def article_options_menu(article)
    #takes article object as an argument
    #automatically displays article headline, network name, and article metadata (i.e. author, date & time posted, number of comments, tags etc.)

    #gives the option for the user to either go to the article in browser or scrape the contents of the article
    self.select_scrape_method(article)

    puts "_____________________________________"
    puts ""
    puts article.network_name
    puts article.headline
    puts article.date
    puts ""
    puts article.summary
    puts ""
    puts "---------------"
    puts ""

    puts "What would you like to do? Enter a number."
    puts "1. View article in browser."
    puts "2. Return to previous menu."
    puts "Or type 'exit'."

    input = gets.strip.upcase
    case input
    when "1"
      Launchy.open(article.url)
    when "2"
      self.display_menu
      self.respond_to_selection(self.select_item)
    when "EXIT"
      self.exit_CLI
    else
      puts "Invalid Selection"
      self.article_options_menu(article)
    end
  end


  def retrieve_article
  end

  def self.display_time
    puts Time.new
  end

end
