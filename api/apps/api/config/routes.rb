# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/health', to: 'health#index'
post '/users', to: 'users#create'
get '/users/me', to: 'users#show'
