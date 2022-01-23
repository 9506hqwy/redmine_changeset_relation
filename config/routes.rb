# frozen_string_literal: true

RedmineApp::Application.routes.draw do
  resources :projects do
    put '/changeset_relation_settings', to: 'changeset_relation_settings#update', format: false
  end
end
