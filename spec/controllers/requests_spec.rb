require 'rails_helper'

describe 'Requests Controller', type: :request do

    before(:each) do
        FactoryBot.create(:user)
        FactoryBot.create(:request)
        
        post '/api/v1/login', params: {email: 'Jane@gmail.com', password: '1234567'}
        @token = JSON.parse(response.body)['token']
    end

    it 'should create a new request' do
        expect {
            post '/api/v1/requests', params: {
                title: 'I need your help',
                reqtype: 'material',
                description: Faker::Lorem.sentence(word_count: 300),
                lat: Faker::Address.latitude,
                lng: Faker::Address.longitude,
                address: Faker::Address.street_address,
                status: 0,
                user_id: 1    
            }, as: :json, headers: {:Authorization => @token}
        }.to change {Request.count}.from(1).to(2)

        expect(response).to have_http_status(:created)
    end

    it 'should return all requests' do
        get '/api/v1/requests', as: :json, headers: {:Authorization => @token}
        expect(response).to have_http_status(:ok)
    end

    it 'should make sure only unfulfilled request are returned' do
        get '/api/v1/requests', as: :json, headers: {:Authorization => @token}
         # make sure all request status is unfulfilled
        requests = JSON.parse(response.body)
        requests.each do |req| 
             expect(req['status']).to eq(0)
        end
    end

    it 'should return all requests as an array' do
        get '/api/v1/requests', as: :json, headers: {:Authorization => @token}
        expect(JSON.parse(response.body)).to be_an_instance_of(Array)
    end

    it 'should find and return a single request' do
        get '/api/v1/requests/1', as: :json, headers: {:Authorization => @token}
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('id')
        expect(response.body).to include('title')
        expect(response.body).to include('reqtype')
        expect(response.body).to include('description')
        expect(response.body).to include('created_at')
        expect(response.body).to include('updated_at')
        expect(response.body).to include('user')
    end
    
    it 'should return all the request of a particular user' do
        get '/api/v1/my-requests', as: :json, headers: {:Authorization => @token}
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data']).to be_an_instance_of(Array)
    end

    it 'should be able to mark a request as fulfilled' do
        patch '/api/v1/requests/1', as: :json, headers: {:Authorization => @token}
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Request marked as fulfilled')
    end

    it 'should be delete a request' do
        delete '/api/v1/requests/1', as: :json, headers: {:Authorization => @token}
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Request deleted')
    end

    it 'should republish a request' do
        patch '/api/v1/republish/1', as: :json, headers: {:Authorization => @token}
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data']['status']).to eq(0)
    end

    it 'should return request count' do
        get '/api/v1/request-counter'
        expect(JSON.parse(response.body)['data']['unfulfilled']).to be_truthy 
        expect(JSON.parse(response.body)['data']['fulfilled']).to be_truthy 
        expect(response).to have_http_status(:ok)
    end

end