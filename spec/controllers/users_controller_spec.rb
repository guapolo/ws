require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    let!(:user_list){ create_list(:user, 4) }
    let!(:user_ids){ user_list.map{|u| u.id}.sort }
    let!(:get_request){ get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
      expect(Oj.load(response.body)['data'].map{|hsh| hsh['id'].to_i}.sort).to eq user_ids
    end
  end

  describe "GET #show" do
    let!(:user){ create(:user) }
    let!(:get_request){ get :show, params: {id: user.id} }

    it "returns http success" do
      expect(response).to have_http_status(:success)
      expect(Oj.load(response.body).dig('data', 'id')).to include user.id.to_s
    end
  end
end
