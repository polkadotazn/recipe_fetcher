class ApplicationController < ActionController::API
  def welcome
    render html: "Recipe puppy will fetch you recipes 🐶"
  end
end
