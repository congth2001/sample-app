Rails.application.routes.draw do
  root "static_pages#home"

  get "/help", to: "static_pages#help" 
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"

  root_path = "/" 
  root_url = "http://www.example.com/"
  help_path = "/help"
  help_url = "http://www.example.com/help"
  about_path = "/about"
  about_url = "http://www.example.com/about"
  contact_path = "/contact"
  contact_url = "http://www.example.com/contact"

  signup_path = "/signup"
end
