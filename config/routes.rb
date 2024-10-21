Rails.application.routes.draw do
  resources :pokemons, only: [:index] do
    collection do
      get 'captured'       
      post 'import'        
    end
    member do
      patch 'capture'    
      patch 'destroy'  
    end
  end

  get 'external_pokemons', to: 'external_pokemons#index'
  get 'external_pokemons/captured', to: 'external_pokemons#captured'
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
