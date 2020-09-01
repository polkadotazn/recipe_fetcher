class SearchesController < ApplicationController
  def index
    @searches = Search.all
    if params[:search_text]
      create
    else
      render json: @searches
    end
  end

  def create
    @search = Search.new(search_params)
    if @search.save
      @search.get_recipes
      @recipes = Recipe.check_for_modifiers(@search.recipes, params)
      render json: @recipes
    end
  end

  def search_params
    params.permit(:search_text)
  end
end
