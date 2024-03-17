# frozen_string_literal: true

Rails.application.routes.draw do
  get 'redirect/feedback'
  root 'home#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  ## todo: when we have a rails app, we can use the following
  # get '/feedback', to: redirect('/feedbacks/new')
  # get '/feedback.html', to: redirect('/feedbacks/new')
  get '/feedback', to: 'redirect#feedback'
  get '/feedback.html', to: 'redirect#feedback'
  resources :feedbacks, only: %i[new]
end
