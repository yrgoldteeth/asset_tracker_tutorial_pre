AssetTrackerTutorial::Application.routes.draw do
  root :to => "dashboard/base#index"
  match "/api/(/:action(/:id))", :to => API

  devise_for :users do
    get 'login', :to => 'devise/sessions#new'
    post 'login', :to => 'devise/sessions#create'
    get 'logout', :to => 'devise/sessions#destroy'
  end

  namespace :admin do
    resources :invoices
    resources :payroll
    resources :users do
      member do
        get :projects
        post :projects
      end
    end
    resources :projects
    resources :unentered_time_report
    resources :weekly_time_report
  end
  get '/admin', :controller => "admin/base", :action => "index"

  resources :clients do
    resources :comments
    resources :contacts
  end

  resources :projects do
    resources :comments
  end

  resources :tickets do
    resources :comments
  end

  resources :work_units do
    resources :comments
  end

  resources :users do
    member do
      put :change_password
      get :historical_time
    end
  end

  resources :comments

  resources :file_attachments

  namespace :dashboard do
    resources :base do
    end
  end

  get '/dashboard', :controller => "dashboard/base", :action => "index"
  get '/dashboard/calendar', :controller => "dashboard/base", :action => "calendar"
  get '/dashboard/client', :controller => "dashboard/base", :action => "client"
  get '/dashboard/project', :controller => "dashboard/base", :action => "project"
  get '/dashboard/recent_work', :controller => "dashboard/base", :action => "recent_work"


end
