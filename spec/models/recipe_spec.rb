require 'rails_helper'

describe Recipe do
  let(:recipe1) do
      {
        "title": "Spicy Asian Tuna Salad",
        "ingredient_count": 8,
        "ingredients": "albacore tuna, chili oil, chili paste, garlic powder, ginger, green onion, mayonnaise, vegetable oil",
        "link": "http://www.recipezaar.com/spicy-asian-tuna-salad-381640",
        "search_id": 1
      }
  end
  let(:recipe2) do
      {
        "title": "Apple Lime Tuna Salad",
        "ingredient_count": 11,
        "ingredients": "apple, eggs, hot sauce, jalapeno, lime, mayonnaise, orange bell pepper, black pepper, red onions, salt, tuna",
        "link": "http://www.recipezaar.com/Apple-Lime-Tuna-Salad-238145",
        "search_id": 1
      }
  end
  let(:recipe3) do
      {
        "title": "Classic Tuna Salad",
        "ingredient_count": 11,
        "ingredients": "celery, dijon mustard, dill pickle, lemon juice, parsley, garlic, black pepper, mayonnaise, red onions, salt, tuna",
        "link": "http://www.recipezaar.com/Classic-Tuna-Salad-109872",
        "search_id": 1
      }
  end
  let(:recipe4) do
      {
        "title": "Pesto Tuna Salad with Sun-Dried Tomatoes",
        "ingredient_count": 4,
        "ingredients": "pesto, mayonnaise, sun dried tomato, parmesan cheese",
        "link": "http://allrecipes.com/Recipe/Pesto-Tuna-Salad-with-Sun-Dried-Tomatoes/Detail.aspx",
        "search_id": 1
      }
  end

  before(:each) do
    @recipes = []
    @recipes << Recipe.create(recipe1)
    @recipes << Recipe.create(recipe2)
    @recipes << Recipe.create(recipe3)
    @recipes << Recipe.create(recipe4)
  end

  it "sorts titles in alphabetical order" do
    params = {sort: "ASC"}
    sorted_recipe_titles = Recipe.check_for_modifiers(@recipes, params).map { |r| r.title }

    expect(sorted_recipe_titles).to eq(["Apple Lime Tuna Salad", "Classic Tuna Salad", "Pesto Tuna Salad with Sun-Dried Tomatoes", "Spicy Asian Tuna Salad"])
  end

  it "filters when a number is given" do
    params = {filter: 10}
    filtered_recipes = Recipe.check_for_modifiers(@recipes, params)

    expect(filtered_recipes.count).to eq(2)
  end
end
