Curex::Application.routes.draw do
  get 'listings/get_index' => 'listings#get_index'
  delete 'listings/:id/:password' => 'listings#destroy', :constraints => { :password => /.*/ }
  get 'listings/:id/edit/:password' => 'listings#edit', :constraints => { :password => /.*/ }
  get 'listings/:id/:password' => 'listings#show', :constraints => { :password => /.*/ }
  resources :listings
  root :to => "listings#index"
end
