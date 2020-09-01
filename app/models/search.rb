class Search < ApplicationRecord
  validates :search_text, presence: true
  has_many :recipes

  BASE_URL = 'http://www.recipepuppy.com/api'

  def get_recipes
    recipe_count = 0
    1.upto(5) do |pg|
      response = get_response(pg)
      parsed_response = parse_response(response)
      pp parsed_response
      save_recipes(parsed_response)
      recipe_count += parsed_response.length
      break if parsed_response.length < 10
    end
    self.update(:recipe_count => recipe_count)
  end

  def get_response(page_num)
    options = {
      query: {
        q: self[:search_text],
        p: page_num
      }
    }
    HTTParty.get(BASE_URL, options)
  end

  def parse_response(response)
    JSON.parse(response)["results"]
  end

  def save_recipes(recipes)

  end
end
