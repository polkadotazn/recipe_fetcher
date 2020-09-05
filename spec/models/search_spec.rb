require 'rails_helper'

describe Search do
  let(:search_example) do
    {
      "search_text": "tuna salad",
      "recipe_count": 50
    }
  end


  it "is a valid search entity" do
    search = Search.new(search_example)
    
    expect(search).to be_valid
  end

  it "returns recipes for a search" do
    search = Search.create(search_example)
    search.get_recipes

    expect(search.recipes.first.search_id).to eq(search.id)
    expect(search.recipes.length).to eq(search.recipe_count)
  end
end
