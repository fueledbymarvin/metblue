class Package
  include Mongoid::Document
  field :origin_airport, type: String
  field :origin_region, type: String
  field :destination_airport, type: String
  field :destination_region, type: String
  field :hotel, type: String
  field :nights, type: Integer
  field :check_in, type: Date
  field :check_out, type: Date
  field :expedia_price, type: Float
  field :jetblue_price, type: Float
  field :tags, type: Array
end
