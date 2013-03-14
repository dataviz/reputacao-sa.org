SindecProcon::Application.routes.draw do
  match '/lg' => "home#lg"

  match "/empresa/:nome" => "companies#show"

  root :to => 'home#index'
end
