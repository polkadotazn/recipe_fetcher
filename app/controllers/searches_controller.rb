class SearchesController < ApplicationController
  def index
    @searches = Search.all
    if params[:search_text]
      if Search.find_by(search_text: params[:search_text])
        show
      else
        create
      end
    else
      render json: @searches
    end
  end

  def create
    @search = Search.new(search_params)
    if @search.save
      @search.get_recipes
      status = "new search"
      response = compile_response(status)
      render json: response
    end
  end

  def show
    @search = Search.find_by(search_text: params[:search_text])
    status = "This term has been previously searched"
    response = compile_response(status)
    render json: response
  end

  private

  def get_search_recipes
    if @search[:recipe_count] > 0
      recipes = Recipe.check_for_modifiers(@search.recipes, params)
      if recipes[0] == "Invalid"
        ["error", recipes.join(' ')]
      else
        recipes
      end
    else
      []
    end
  end

  def compile_response(status)
    response_code = status == "new search" ? 201 : 200
    recipes = get_search_recipes

    if recipes.empty?
      response_code = 204
      status = "search_text: #{params[:search_text]}; no results"
    elsif recipes[0] == "error"
      response_code = 422
      status = "#{recipes[1]}"
      recipes = []
    end

    {
      response_code: response_code,
      message: status,
      recipes: recipes
    }
  end

  def search_params
    params.permit(:search_text)
  end
end
