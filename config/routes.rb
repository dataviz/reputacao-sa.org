SindecProcon::Application.routes.draw do

  match "/empresas" => "companies#index"
  match "/:nome" => "companies#show"


  root :to => 'home#index'

end
