class Api::V1::ClacbtCheckCandidatesController < ApplicationController
  # Publicly display a candidate
  def check_candidate
    ActiveRecord::Base.connection.clear_cache! # Clear cache to ensure latest data is fetched
  
    # Ensure exam_code is provided
    unless params[:exam_code].present?
      return render json: { error: "Exam code is required" }, status: :bad_request
    end
  
    # Find exam safely
    exam = ClacbtExam.find_by(exam_code: params[:exam_code])
    return render json: { error: "Exam not found" }, status: :not_found unless exam
  
    # Find candidate (ignoring case for email)
    candidate = exam.clacbt_candidates.find_by("LOWER(email) = ?", params[:email].to_s.downcase)
  
    if candidate&.score.nil?
      render json: { 
        message: "Candidate authorized", 
        candidate: {
          id: candidate.id,
          email: candidate.email, 
          exam_code: exam.exam_code 
        } 
      }, status: :ok
    else
      render json: { error: "Unauthorized candidate" }, status: :unauthorized
    end
  end
end
