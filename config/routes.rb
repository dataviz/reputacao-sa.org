SindecProcon::Application.routes.draw do

  match "/empresa/:nome" => "companies#show"
  match "/empresas" => "companies#index"

  root :to => 'home#index'

end
