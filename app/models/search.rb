class Search
  include Mongoid::Document
  include Mongoid::SortedRelations
  field :destinations, type: Array
  field :regions, type: Array
  field :tags, type: Array
  field :budget, type: Float

  has_and_belongs_to_many :packages, inverse_of: nil

  before_create :rank

  private

  def rank
    self.packages = Package.all
  end
end
