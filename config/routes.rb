Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace 'api' do
    namespace 'v1' do
      resources :users, only: [:index, :create]
      post '/login', to: "users#login"

      resources :requests
      get '/my-requests', to: "requests#my_request"
      patch '/republish/:request_id', to: "requests#republish"
      get '/request-counter', to: "requests#request_counter"

      resources :volunteers, only: [:index, :create]
      get '/my-volunteerings', to: "volunteers#my_volunteerings"

      resources :messages
      get '/my-messages', to: 'messages#my_messages'
      get '/chat/:request_id/:user_id', to: 'messages#get_chat_messages'
      get '/notifications', to: 'messages#message_notifications'
      patch '/read-status/:request_id/:user_id', to: 'messages#update_read_status'
    end
  end

end
