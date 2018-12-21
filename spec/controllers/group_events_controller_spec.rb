require 'rails_helper'

RSpec.describe GroupEventsController, type: :controller do
  describe "GET #index" do
    let!(:user){ create(:user) }
    let!(:group_event_list){ create_list(:group_event, 4, user: user) }
    let!(:group_event_ids){ group_event_list.map{|ge| ge.id}.sort }
    let!(:get_request){ get :index, params: {user_id: user.id} }

    it "returns http success" do
      expect(response).to have_http_status(:success)
      expect(Oj.load(response.body)['data'].map{|hsh| hsh['id'].to_i}.sort).to eq group_event_ids
    end
  end

  describe "GET #show" do
    let!(:group_event){ create(:group_event) }
    let!(:get_request){ get :show, params: {id: group_event.id, user_id: group_event.user.id} }

    it "returns http success" do
      expect(response).to have_http_status(:success)
      expect(Oj.load(response.body).dig('data', 'id')).to include group_event.id.to_s
    end
  end

  describe 'POST #create' do
    let!(:user){ create(:user) }
    let!(:params){
      {
        user_id: user.id,
        data: {
          type: 'group_event',
          attributes: { name: "Some event" }
        }
      }
    }
    let!(:post_request){ post :create, params: params }

    it 'creates a Group Event' do
      expect(response).to have_http_status(:created)
      expect(user.group_events.count).to eq 1
      expect(user.group_events.first.name).to eq "Some event"
    end
  end

  describe 'PUT #update' do
    let!(:group_event){ create(:group_event) }
    let!(:params){
      {
        id: group_event.id,
        user_id: group_event.user.id,
        data: {
          type: 'group_event',
          attributes: { name: "New event name" }
        }
      }
    }
    let!(:put_request){ put :update, params: params }

    it 'updates a Group Event' do
      expect(response).to have_http_status(:ok)
      expect(group_event.reload.name).to eq "New event name"
    end
  end

  describe 'DELETE #destroy' do
    let!(:group_event){ create(:group_event) }
    let!(:params){
      {
        id: group_event.id,
        user_id: group_event.user.id
      }
    }
    let!(:delete_request){ delete :destroy, params: params }

    it 'soft deletes a Group Event' do
      expect(response).to have_http_status(:ok)
      group_event.reload
      expect(group_event).to be_deleted
    end
  end
end
