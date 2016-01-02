Rails.application.routes.draw do
  get 'get_data' => 'static#get_data', defaults: {format: :json}
  root 'static#home'
end
