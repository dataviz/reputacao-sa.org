SindecProcon::Application.routes.draw do

  match "/empresas" => "companies#index", as: :companies
  match "/buscar" => "companies#search", as: :companies_search
  match "/:slug" => "companies#show", as: :companies_show


  root :to => 'home#index'

end
