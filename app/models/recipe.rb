class Recipe < ApplicationRecord
  validates :title, :ingredient_count, :ingredients, presence: true
  belongs_to :search

  def self.check_for_modifiers(recipes, params)
    recipes = filter_ingredients(recipes, params[:filter]) if params[:filter]
    recipes = sort_by_title(recipes) if params[:sort] == "true"
    pp recipes
  end

  def self.sort_by_title(recipes)
    recipes.sort_by { |r| r[:title] }
  end

  def self.filter_ingredients(recipes, limit)
    recipes.filter { |r| r[:ingredient_count] <= limit.to_i }
  end

end
