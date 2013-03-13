SindecProcon::Application.routes.draw do
  match '/lg' => "home#lg"
  root :to => 'home#index'
end
