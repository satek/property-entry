require "thor"
require "db_setup.rb"
require "models/property.rb"
require "user_interaction.rb"

class Wimdu < Thor
  include UserInteraction

  desc "new", "enter new property"
  def new
    new_property!
    say "Starting with new property ##{property.id}"
    interact!
  end

  desc "continue", "continue with previously entered property"
  def continue property_id
    find_property property_id
    unless property
      say "Could not find the property"
      return
    end
    say "Continuing with #{property_id}"
    interact!
  end

  desc "list", "list properties"
  def list
    unless Property.completed.any?
      say "No completed properties found"
      return
    end
    Property.completed.each do |property|
      say "ID: #{property.id}"
      say "Title: #{property.title}"
      say "Property type: #{property.property_type}"
      say "Address: #{property.address}"
      say "Nightly rate in EUR: #{property.nightly_rate}"
      say "Max guests: #{property.max_guests}"
      say "Email: #{property.email}"
      say "Phone number: #{property.phone_number}"
      say "-------------------------------------"
    end
  end

end
