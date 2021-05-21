require 'rails_helper'

describe 'Users Controller', type: :request do
    before(:each) do
        FactoryBot.create(:user)
    end

    it 'should allow a user to log in' do
        post '/api/v1/login', params: {email: 'Jane@gmail.com', password: '1234567'}
        expect(response).to have_http_status(:ok)
    end

    it 'should include user token in response upon successful login' do
        post '/api/v1/login', params: {email: 'Jane@gmail.com', password: '1234567'}
        expect(response.body).to include('token')
    end

    it 'should return count of all users' do
        get '/api/v1/users'

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
    end

end