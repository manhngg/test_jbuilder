Rails.application.routes.draw do
  namespace :api, format: "json" do
    namespace :v1 do
      get "stores", to: "stores#index"
    end
  end
end
