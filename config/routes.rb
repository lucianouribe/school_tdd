Rails.application.routes.draw do

  root 'kindergartens#index'

  resources :kindergartens do
    resources :lessons
  end

end
