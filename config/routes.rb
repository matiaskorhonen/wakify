ActionController::Routing::Routes.draw do |map|
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.static 'static/:permalink', :controller => 'pages', :action => 'show'
  map.account 'edit_account', :controller => 'users', :action => 'edit'
  map.user_home 'me', :controller => 'users', :action => 'show'
  map.activate 'activate/:activation_code', :controller => 'users', :action => 'activate'
  map.requests 'requests', :controller => 'users', :action => 'requests'
  map.password_reset 'password_reset/:code', :controller => 'users', :action => 'reset_password'
  map.contact 'contact', :controller => 'messages', :action => 'new'
  
  map.resources :sessions
  map.resources :users
  map.resources :computers
  map.resources :wakeonlan
  map.resources :pages
  map.resources :messages
  
  map.root :controller => "home"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
