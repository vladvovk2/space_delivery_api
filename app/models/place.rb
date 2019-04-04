class Place < ApplicationRecord
  belongs_to :order, optional: true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  before_save :split_address

  def split_address
    self.address = address.split(', Черкассы').first
  end
end
