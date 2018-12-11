Rails.application.routes.draw do
  get 'tasks/',         to: 'tasks#index',   as: 'tasks_index'
  get 'tasks/new',      to: 'tasks#new',     as: 'tasks_new'
  get 'tasks/:id/edit', to: 'tasks#edit',    as: 'tasks_edit'
  post 'tasks/',        to: 'tasks#create',  as: 'tasks_create'
  post 'tasks/:id',     to: 'tasks#update',  as: 'tasks_update'
  get 'tasks/:id',      to: 'tasks#show',    as: 'tasks_show'
  delete 'tasks/:id/destroy',   to: 'tasks#destroy', as: 'tasks_destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'tasks#index'
end
