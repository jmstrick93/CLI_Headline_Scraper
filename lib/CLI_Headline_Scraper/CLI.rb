#Our CLI Controller
require 'pry'

class CLIHeadlineScraper::CLI

  def call
    puts "Welcome to Headline Scraper"
    puts "Please select which of the following headlines you would like to view:"

    puts "  1. Main"
    puts "  2. Politics"
    puts "  3. Tech"

    puts "Or type 'exit'."

    select_group #initial menu selection of what you want to see
    select_item
    retrieve_item #retrieves webpage by using either #retrieve_hompage or #retrieve_article.


  end

  def select_group
    selection = gets.strip
    case selection
    when "1"
      puts <<~HEREDOC

      August 27, 2017:

      To go to a story, type the network name and then the article number (e.g., BBC 2)
      _____________________________________

      BBC
      1. "Houston Flooding 'Epic, Catastrophic'"
      2. "US transgender military ban challenged"
      3. "Reporter rescues lorry driver live on air"


      MSNBC
      1. "FEMA Chief: Harvey Damage 'is just the begining'"
      2. "Joe: Arpaio a 'thug' and his pardon could haunt Trump"
      3. "MaddowBlog: Fresh details add context to Trump-Russia"


      CNN
      1."Catastrophic flooding traps Houston residents"
      2. "How a request about Russians made its way to Trump's team"
      3. "Trump ends Obama-era rules on military gear for local police"


      FOX NEWS
      1. "CRIPPLED CITY - Waterlogged Houston recovers, awaits Round 2 from Harvey"
      2. "CABINET CRACKS? - Tillerson, others seen as distancing from Trump"
      3. "'SOME WILL DIE' - VA Worker alerts Trump to new wait-list problem"


      AL JAZEERA
      1. "Worst yet to come" as Harvey displaces 30,000 in Texas"
      2. "Indian sect leader sentenced to 20 years for rape"
      3. "Netanyahu: Iran building missile sites in Syria"


      NPR
      1. "Flooded Houston Braces for More Rain and a Long Recovery from Harvey"
      2. "After Arpaio, 4 Answers to Questions About How Pardons Are Supposed To Work"
      3. "2 Lawsuits Challenge Trump's Ban on Transgender Military Service"
      _____________________________________


      HEREDOC

    when "exit"
      puts "Goodbye"
      exit
    end

  end

  def select_item #returns an array where arr[0] is the network name and arr[1] is the article number/
    puts "To go to a story, type the network name and then the article number (e.g., BBC 2)"

    selection = gets.strip.split(" ")
    if selection.length == 2
      selection[1] = selection[1].to_i
    elsif selection.length > 2
      puts "invalid entry"
      select_item
    end

    selection

  end

  def retrieve_item
  end

  def retrieve_homepage
  end

  def retrieve_article
  end



#
#
#     case selection[0]
#
#     when networks.all[0]
#       if selection.length > 1
#         case selection[1]
#         when "1"
#           #load article 1
#         when "2"
#           #load article 2
#         when "3"
#           #load article 3
#         end
#       else
#         #load BBC homepage
#       end
#
#
#
#
#
#
end
