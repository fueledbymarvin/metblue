class Search
  include Mongoid::Document
  include Mongoid::SortedRelations
  field :origin_airport
  field :origin_region
  field :destination_airports, type: Array
  field :destination_regions, type: Array
  field :tags, type: Array
  field :budget, type: Float
  field :start_date, type: Date
  field :end_date, type: Date

  has_and_belongs_to_many :packages, inverse_of: nil

  before_create :rank

  private

  def rank
    self.packages = Package.all
  end
end
