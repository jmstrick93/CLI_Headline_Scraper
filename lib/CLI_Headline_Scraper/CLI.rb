#Our CLI Controller
class CLI

  attr_reader :time

  def initialize
  end

  def call
    puts "Welcome to Headline Scraper"
    puts "Please select which of the following articles you would like to view:"

    display_menu #initial menu selection of what you want to see
    select_item
    retrieve_item #retrieves webpage by using either #retrieve_hompage or #retrieve_article.
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

  def valid_selection?(selection)
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
    until valid_selection?(selection)
      puts "To go to a newtork homepage, just type the name of that network."
      puts "To go to a specific story, type the network name and then the article number, separated by a colon (e.g., BBC : 2)"
      #maybe later insert "back" functionality.
      puts "To exit at any time, type 'exit'."

      selection = gets.strip
      selection = selection.split(":") if selection != nil
      if valid_selection?(selection)
        selection[0].strip!
        selection[0] = selection[0].upcase
        if selection.length == 2
          selection[1].strip!
          selection[1] = selection[1].to_i
        end

      else
        puts "Invalid Entry"
      end

      if selection[0] == 'EXIT'
        self.exit_CLI
      end
    end
    selection
  end

  def exit_CLI
    puts "Goodbye!"
    exit
  end

  def respond_to_selection(selection)


  end

  def go_to_homepage
  end

  def retrieve_article
  end

  def self.display_time
    puts Time.new
  end

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
