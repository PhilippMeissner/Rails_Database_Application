Rails.application.routes.draw do
  get 'get_data' => 'static#get_data', defaults: {format: :json}
  get 'get_data_second' => 'static#get_data_second', defaults: {format: :json}
  get 'get_data_third' => 'static#get_data_third', defaults: {format: :json}
  root 'static#home'
end
