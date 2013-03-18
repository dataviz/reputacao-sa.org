SindecProcon::Application.routes.draw do

  match "/empresas" => "companies#index"
  match "/buscar" => "companies#search", as: :companies_search
  match "/:slug" => "companies#show", as: :companies_show


  root :to => 'home#index'

end
