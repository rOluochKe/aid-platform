require 'rails_helper'

describe 'Volunteers Controller', type: :request do

    before(:each) do
        FactoryBot.create(:user)
        FactoryBot.create(:user1)
        FactoryBot.create(:request)
        FactoryBot.create(:request1)
        FactoryBot.create(:volunteer1)

        post '/api/v1/login', params: {email: 'Jane@gmail.com', password: '1234567'}
        @token = JSON.parse(response.body)['token']
     end

     it 'should get all a users volunteerings' do
         get '/api/v1/my-volunteerings', as: :json, headers: {:Authorization => @token}

         expect(response).to have_http_status(:ok)
     end

      it 'should include the request on the user volunteerings' do
        get '/api/v1/my-volunteerings', as: :json, headers: {:Authorization => @token}

        expect(response.body).to include('request')
     end

     it 'should allow a user to volunteer on a request' do
        expect{
            post '/api/v1/volunteers', params: {
                request_id: 2,
                requester_id: 1
            }, as: :json, headers: {:Authorization => @token}
        }.to change { Volunteer.count}.from(1).to(2)
        
        expect(response).to have_http_status(:created)
     end

end