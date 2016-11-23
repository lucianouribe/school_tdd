Rails.application.routes.draw do
  get 'kindergartens/index'

  get 'kindergartens/edit'

  get 'kindergartens/new'

  get 'kindergartens/show'

  resources :kindergartens
end
