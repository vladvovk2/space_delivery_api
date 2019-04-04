class Place < ApplicationRecord
  belongs_to :order, optional: true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
end
