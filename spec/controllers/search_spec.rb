require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let!(:search1) { Search.create(search_text: "cookie") }
  let!(:search2) { Search.create(search_text: "chicken") }
  let!(:search3) { Search.create(search_text: "cat") }
  let!(:search4) { Search.create(search_text: "crumb") }

  describe '#index' do
    it "shows all searches" do
      get :index
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(4)
    end
  end

  describe '#create' do
    it "creates a new search" do
      pie_search = Search.create(search_text: "pie")
      expect(Search.find_by(search_text: "pie")[:id]).to eq(pie_search[:id])
    end
  end

  describe '#show' do
    it "selects a previous search" do
      cookie_search = Search.find_by(search_text: "cookie")
      expect(cookie_search[:id]).to eq(search1[:id])
    end
  end
end
