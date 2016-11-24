Rails.application.routes.draw do

  get 'lessons/index'

  get 'lessons/new'

  get 'lessons/edit'

  get 'lessons/show'

  get 'kindergartens/index'

  get 'kindergartens/edit'

  get 'kindergartens/new'

  get 'kindergartens/show'

  resources :kindergartens do
    resources :lessons
  end

end
