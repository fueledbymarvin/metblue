class Search
  include Mongoid::Document
  include Mongoid::SortedRelations
  field :origin_airports, type: Array
  field :origin_regions, type: Array
  field :destination_airports, type: Array
  field :destination_regions, type: Array
  field :tags, type: Array
  field :budget, type: Float
  field :start_date, type: Date
  field :end_date, type: Date

  embedded_in :user
  has_and_belongs_to_many :packages, inverse_of: nil

  before_save :rank

  private

  def rank
    packages = []
    Package.all.each do |package|
      packages << { package: package, score: score(package) } if relevant? package
    end
    packages.sort_by! { |package| package[:score] }
    packages.reverse!
    packages.map! { |package| package[:package] }

    self.packages = packages
  end

  def relevant?(package)
    rel = true
    if start_date && end_date
      rel &= package.check_in >= start_date && package.check_out <= end_date
    end
    if budget
      rel &= package.jetblue_price <= budget
    end
    if tags
      rel &= !(package.tags & tags).empty?
    end
    if destination_airports && destination_regions
      rel &= destination_airports.include?(package.destination_airport) ||
        destination_regions.include?(package.destination_region)
    elsif destination_airports
      rel &= destination_airports.include?(package.destination_airport)
    elsif destination_regions
      rel &= destination_regions.include?(package.destination_region)
    end
    if origin_airports && origin_regions
      rel &= origin_airports.include?(package.origin_airport) ||
        origin_regions.include?(package.origin_region)
    elsif origin_airports
      rel &= origin_airports.include?(package.origin_airport)
    elsif origin_regions
      rel &= origin_regions.include?(package.origin_region)
    end

    rel
  end

  def score(package)
    score_criteria get_criteria(package)
  end

  def get_criteria(package)
    criteria = []

    if origin_airports
      criteria << {
        weight: 2,
        options: [{
                    weight: 1,
                    value: origin_airports.include?(package.origin_airport) ? 1 : 0
                  }]
      }
    end

    if origin_regions
      criteria << {
        weight: 2,
        options: [{
                    weight: 1,
                    value: origin_regions.include?(package.origin_region) ? 1 : 0
                  }]
      }
    end

    if destination_airports
      criteria << {
        weight: 2,
        options: [{
                    weight: 1,
                    value: destination_airports.include?(package.destination_airport) ? 1 : 0
                  }]
      }
    end

    if destination_regions
      criteria << {
        weight: 2,
        options: [{
                    weight: 1,
                    value: destination_regions.include?(package.destination_region) ? 1 : 0
                  }]
      }
    end

    if tags
      tags_crit = { weight: 2, options: [] }
      tags.each_index do |i|
        tags_crit[:options] << { 
          weight: tags.size - i,
          value: package.tags.include?(tags[i]) ? 1 : 0
        }
      end
      criteria << tags_crit
    end

    if budget
      criteria << {
        weight: 2,
        options: [{
                    weight: 1,
                    value: (budget - package.jetblue_price) / budget
                  }]
      }
    end

    criteria
  end

  def score_criteria(criteria)
    if criteria.empty?
      return 0
    end

    score = 0.0
    max_score = 0.0
    criteria.each do |criterion|
      sub_score = 0.0
      max_sub_score = 0.0
      criterion[:options].each do |option|
        sub_score += option[:value] * option[:weight]
        max_sub_score += option[:weight]
      end

      score += sub_score / max_sub_score * criterion[:weight]
      max_score += criterion[:weight]
    end

    score / max_score
  end
end
