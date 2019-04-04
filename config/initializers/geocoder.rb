Geocoder.configure(
  api_key: Rails.application.secrets.google_place_key,
  language: :ru,

  distances: :linear
)
