SindecProcon::Application.routes.draw do

  match "/empresa/:nome" => "companies#show"

  root :to => 'home#index'

end
