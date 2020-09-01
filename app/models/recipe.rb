class Recipe < ApplicationRecord
  validates :title, :ingredient_count, :ingredients, presence: true
  belongs_to :search

  def self.check_for_modifiers(recipes, params)
    if params[:filter].to_i > 0
      recipes = filter_ingredients(recipes, params[:filter])
    elsif params[:filter]
      return ["Invalid", "filter", "- Please use an integer"]
    end

    sort_type = params[:sort]&.upcase
    if sort_type == "ASC" || sort_type == "DESC"
      recipes = sort_by_title(recipes, sort_type)
    elsif params["sort"]
      return ["Invalid", "sort", "- Use 'ASC' or 'DESC'"]
    end
    recipes
  end

  def self.sort_by_title(recipes, sort_type)
    if sort_type == "ASC"
      recipes.sort_by { |r| r[:title] }
    else
      recipes.sort_by { |r| r[:title] }.reverse
    end
  end

  def self.filter_ingredients(recipes, limit)
    recipes.filter { |r| r[:ingredient_count] <= limit.to_i }
  end
end
