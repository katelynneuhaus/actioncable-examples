#*DTA Here!
Rails.application.routes.draw do
  resource  :session
  resources :examples

  resources :messages do
    resources :comments
  end

  resources :syncs

  root 'examples#index'
end
