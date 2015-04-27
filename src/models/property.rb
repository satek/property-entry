class Property < ActiveRecord::Base
  cattr_accessor :property_types

  validates :nightly_rate, :max_guests,
            numericality: { greater_than: 0, allow_nil: true }

  scope :completed, -> { where("title is not null and property_type is not null and 
                                address is not null and nightly_rate is not null and max_guests is not null and
                                email is not null and phone_number is not null") }

  @@property_types = ["holiday home", "apartment", "private room"]
  validates_inclusion_of :property_type, in: property_types
    

  def complete?
    title and address and nightly_rate and max_guests and
    email and phone_number
  rescue NoMethodError
    false
  end
end
