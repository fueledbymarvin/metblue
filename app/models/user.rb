class User
  include Mongoid::Document
  field :destinations, type: Array
  field :regions, type: Array
  field :tags, type: Array
  field :budget, type: Float
end
