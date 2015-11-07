class Package
  include Mongoid::Document
  field :origin_airport, type: String
  field :destination_airport, type: String
  field :tags, type: Array
  field :hotel, type: String
  field :nights, type: Integer
  field :check_in_date, type: Date
  field :check_out_date, type: Date
  field :expedia_price, type: Float
  field :jetblue_price, type: Float
  field :region, type: String
end
