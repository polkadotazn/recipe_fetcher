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
    context "when there are new valid results" do
      it "creates a new search" do
        pie_search = Search.create(search_text: "pie")
        expect(Search.find_by(search_text: "pie")[:id]).to eq(pie_search[:id])
      end

      it "returns a 201 code" do
        post :create, params: { search_text: "corn cheese" }
        expect(JSON.parse(response.body)["response_code"]).to eq(201)
      end
    end

    context "when there are no recipes found for the search term" do
      it "returns a 204 code" do
        post :create, params: { search_text: "zsdfoijaoweigja" }
        expect(JSON.parse(response.body)["response_code"]).to eq(204)
      end
    end
  end

  describe '#show' do
    before(:each) do
      @cookie_search = Search.find_by(search_text: "cookie")
    end

    it "selects a previous search" do
      expect(@cookie_search[:id]).to eq(search1[:id])
    end

    it "returns a 200 response code" do
      get :show, params: { id: @cookie_search[:id], search_text: "cookie" }
      expect(response.status).to eq(200)
    end
  end

  describe 'when filter is incorrectly formatted' do
    it "returns 422" do
      post :create, params: { search_text: "crudites", filter: "no" }

      expect(JSON.parse(response.body)["response_code"]).to eq(422)
    end
  end

  describe 'when sort is incorrectly formatted' do
    it "returns 422" do
      post :create, params: { search_text: "crudites", sort: true }

      expect(JSON.parse(response.body)["response_code"]).to eq(422)
    end
  end
end
