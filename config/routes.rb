# typed: strict
# frozen_string_literal: true

Rails.application.routes.draw do
  root "home_page#index"

  get "/sitemap.xml.gz", to: redirect("https://hotseat-sitemaps.s3.amazonaws.com/sitemap.xml.gz")
  get "/sitemap1.xml.gz", to: redirect("https://hotseat-sitemaps.s3.amazonaws.com/sitemap1.xml.gz")
  get "/sitemap2.xml.gz", to: redirect("https://hotseat-sitemaps.s3.amazonaws.com/sitemap2.xml.gz")

  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    sessions: "sessions",
  }

  devise_scope :user do
    get "sign_in", to: "devise/sessions#new", as: :new_user_session
    delete "sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  mount Ahoy::Engine => "/hotcount"

  authenticated :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: "blazer"
  end
  authenticate :user, ->(user) { user.admin? } do
    mount Searchjoy::Engine, at: "searchjoy"
  end

  namespace :admin do
    resources :reviews
  end

  get "checkout", to: "checkouts#checkout"

  resources "subject_areas", only: %i[index show], path: "subject-areas"
  resources "courses", only: %i[index show] do
    get "/instructors/:id", to: "courses#show_instructor", as: :instructor
  end
  resources "reviews", only: %i[new create edit update]
  get "/reviews/course-suggestions", to: "reviews#course_suggestions"
  get "/reviews/term-suggestions", to: "reviews#term_suggestions"
  get "/reviews/section-suggestions", to: "reviews#section_suggestions"

  resources "instructors", only: %i[index show]

  get "/search", to: "search#index"
  get "/search/suggestions", to: "search#suggest"

  get "/enroll/:id", to: "sections#enroll", as: :enroll

  # Users
  get "/my-courses", to: "users#my_courses"
  get "/user/details", to: "users#details"
  get "/settings", to: "users#edit"
  post "users/verify-phone", to: "users#verify_phone"
  post "users/confirm-verify-phone", to: "users#confirm_verify_phone"
  put "users/remove-phone", to: "users#remove_phone"
  resources "users", only: %i[update]

  resources "relationships", only: %i[create destroy]
  get "/unsubscribe/:id", to: "relationships#unsubscribe", as: :unsubscribe

  resources "enrollment_notifications", only: %i[create]

  resources "webpush_devices", only: %i[index create destroy]

  # 404 and 500 pages
  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unprocessable_entity", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  # High Voltage routes
  get "/*id" => "pages#show", as: :page, format: false
end
