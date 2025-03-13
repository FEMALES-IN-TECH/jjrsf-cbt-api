Rails.application.routes.draw do
  # Health check endpoint
  get "up", to: "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      # Authentication routes
      post "/signup", to: "registration#create"
      post "/login", to: "authentication#create"

      # Exam routes
      resources :clacbt_exams, except: [:new, :edit] do
        resources :clacbt_questions, except: [:new, :edit]  # Nested under exams
        resources :clacbt_candidates, except: [:new, :edit] # Nested under exams
        collection do
          get 'display_exam'  # Route for displaying an exam without authentication
        end
      end

      resources :clacbt_candidates, only: [:index, :show, :create, :update, :destroy]


      # resources :clacbt_exams, only: [:index, :show, :create, :update, :destroy]

      # Question routes
      get "clacbt_questions/display/:id", to: "clacbt_questions#display_question", as: "display_clacbt_question"

      # Answer routes
      resources :clacbt_questions, only: [] do
        resources :clacbt_answers, except: [:new, :edit]  # Nested under questions
      end
      get "clacbt_answers/:id/display", to: "clacbt_answers#display_answer", as: "display_clacbt_answer"

      # config/routes.rb
      get 'clacbt_check_candidates/check', to: 'clacbt_check_candidates#check_candidate'

    end
  end
end
