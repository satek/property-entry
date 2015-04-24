require "thor"
require "db_setup.rb"
require "models/property.rb"

module UserInteraction
  attr_accessor :property

  def new_property!
    self.property = Property.create
  end

  def find_property id
    self.property = Property.find id
  end

  def enter_title!
    property.title = ask("\nTitle: ")
    property.save
  end

  def enter_address!
    property.address = ask("Address: ")
    property.save
  end

  def enter_nightly_rate!
    nightly_rate = ask("Nightly rate in EUR: ")
    property.nightly_rate = nightly_rate
    property.save
  end

  def enter_max_guests!
    property.max_guests = ask("Max guests: ")
    property.save
  end

  def enter_email!
    property.email = ask("Email: ")
    property.save
  end

  def enter_phone_number!
    property.phone_number = ask("Phone number: ")
    property.save
  end

  def interact!
    enter_title! unless property.title
    enter_address! unless property.address
    enter_nightly_rate! unless property.nightly_rate
    enter_max_guests! unless property.max_guests
    enter_email! unless property.email
    enter_phone_number! unless property.phone_number
  end
end

class Wimdu < Thor
  include UserInteraction

  desc "new", "enter new property"
  def new
    say "Starting with new property."
    new_property!
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

end

