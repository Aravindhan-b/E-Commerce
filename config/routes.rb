Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: 'admin/categories#parent_categories'
  namespace :admin do
    resources :products
    resources :categories do
      collection do
        get :parent_categories
      end
    end
  end
end
