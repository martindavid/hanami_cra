# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/health', to: 'health#index'
get '/users/me', to: 'users#show'
post '/signup', to: 'users#create'
post '/signin', to: 'sessions#create'
post '/signin/oauth', to: 'sessions#oauth'
