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
      end

      get "clacbt_exams/display", to: "clacbt_exams#display_exam", as: "display_clacbt_exam"

      # Question routes
      get "clacbt_questions/display/:id", to: "clacbt_questions#display_question", as: "display_clacbt_question"

      # Answer routes
      resources :clacbt_questions, only: [] do
        resources :clacbt_answers, except: [:new, :edit]  # Nested under questions
      end
      get "clacbt_answers/:id/display", to: "clacbt_answers#display_answer", as: "display_clacbt_answer"

      # Candidate check route (for authentication)
      get "clacbt_candidates/check", to: "clacbt_candidates#check_candidate", as: "check_clacbt_candidate"
    end
  end
end
