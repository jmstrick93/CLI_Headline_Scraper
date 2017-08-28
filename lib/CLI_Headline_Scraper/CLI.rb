#Our CLI Controller

class CLIHeadlineScraper::CLI

  def call
    puts "Welcome to Headline Scraper"
    puts "Please select which of the following headlines you would like to view:"

    puts "  1. Main"
    puts "  2. Politics"
    puts "  3. Tech"

    puts "Or type 'exit.'"

    selection = gets.strip

    make_selection(selection)

  end

  def make_selection(selection)
    
  end

end
