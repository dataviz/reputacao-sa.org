SindecProcon::Application.routes.draw do
  match '/proto' => "companies#proto"

  match "/empresa/:nome" => "companies#show"

  root :to => 'home#index'
end
