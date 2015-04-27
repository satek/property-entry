module UserInteraction
  attr_accessor :property

  def new_property!
    self.property = Property.create
  end

  def find_property id
    self.property = Property.find id
  end

  def enter_title!
    input = ask("\nTitle: ")
    return if input == ""
    property.title = input
    property.save
  end

  def enter_property_type!
    while property.property_type == nil or
          !property.valid?
      input = ask("Property type (possible values #{Property.property_types}): ")
      return if input == ""
      property.property_type = input
      say(property.errors.messages) unless property.save
    end
  end

  def enter_address!
    input = ask("Address: ")
    return if input == ""
    property.address = input
    property.save
  end

  def enter_nightly_rate!
    while property.nightly_rate == nil or
          !property.valid?
      input = ask("Nightly rate in EUR: ")
      return if input == ""
      property.nightly_rate = input
      say(property.errors.messages) unless property.save
    end
  end

  def enter_max_guests!
    while property.max_guests == nil or
          !property.valid?
      input = ask("Max guests: ")
      return if input == ""
      property.max_guests = input
      say(property.errors.messages) unless property.save
    end
  end

  def enter_email!
    input = ask("Email: ")
    return if input == ""
    property.email = input
    property.save
  end

  def enter_phone_number!
    input = ask("Phone number: ")
    return if input == ""
    property.phone_number = input
    property.save
  end

  def interact!
    enter_title! unless property.title
    enter_property_type! unless property.property_type
    enter_address! unless property.address
    enter_nightly_rate! unless property.nightly_rate
    enter_max_guests! unless property.max_guests
    enter_email! unless property.email
    enter_phone_number! unless property.phone_number
    say("Finished input.")
    if property.complete?
      say("Property is complete.")
    else
      say("Property is not complete.")
    end
  end
end
