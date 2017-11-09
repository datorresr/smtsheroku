Rails.application.routes.draw do
  get 'videos/new'

  get 'sesiones/new'


  root   'static_pages#inicio'
  #get    '/root_path', to: 'static_pages#inicio'
  get    '/nosotros',  to: 'static_pages#nosotros'
  get    '/ingresar',  to: 'sesiones#new'
  post   '/ingresar',  to: 'sesiones#create'
  get    '/contacto',  to: 'static_pages#contacto'
  get    '/registro',  to: 'usuarios#new'
  post   '/registro',  to: 'usuarios#create'
  get    '/ingreso',   to: 'sesiones#new'
  #  post   '/ingreso',   to: 'sesiones#create'
  delete '/salida',     to: 'sesiones#destroy'
  get    '/sites/:id', to: 'concursos#show'
  post   '/sites/:id', to: 'concursos#create'
  post   '/concursos/:id', to: 'concursos#edit'
  get   '/concursos/:id', to: 'concursos#show'
  resources :videos
  resources :usuarios
  resources :concursos, only: [:update, :create, :destroy]
end
