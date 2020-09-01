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
      render json: response.to_json
    end
  end

  def show
    @search = Search.find_by(search_text: params[:search_text])
    status = "This term has been previously searched"
    response = compile_response(status)
    render json: response.to_json
  end

  private

  def get_search_recipes
    if @search[:recipe_count] > 0
      Recipe.check_for_modifiers(@search.recipes, params)
    else
      {"recipes" => 0, "search_text": @search[:search_text]}.to_json
    end
  end

  def compile_response(status)
    response_code = status == "new search" ? 201 : 200
    recipes = get_search_recipes
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
