class Api::V1::ClacbtCandidatesController < ApplicationController  
  before_action :authenticate_token!, except: [:update] 
  before_action :set_exam, only: [:index, :create]
  before_action :set_candidate, only: [:show, :update, :destroy]

  # Fetch candidates for a specific exam (Only exam owner can view)
  def index
    render json: @exam.clacbt_candidates
  end

  # Show a specific candidate
  def show
    render json: @candidate
  end

  # Candidate registration (Public can register)
  def create
    candidate = @exam.clacbt_candidates.build(candidate_params)
    if candidate.save
      render json: candidate, status: :created
    else
      render json: candidate.errors, status: :unprocessable_entity
    end
  end

  # Update candidate (Only exam owner can update)
  def update
    if @candidate.update(candidate_params)
      CandidateMailer.candidate_updated(@candidate).deliver_now
      render json: @candidate, status: :ok
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  # Delete a candidate (Only exam owner can delete)
  def destroy
    @candidate.destroy
    render json: { message: "Candidate deleted successfully" }, status: :ok
  end
  
  private

  def set_exam
    @exam = ClacbtExam.find(params[:exam_id])

    # Ensure only the exam creator can manage candidates
    unless @exam.clacbt_user == current_user
      render json: { error: "Unauthorized access" }, status: :forbidden
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Exam not found" }, status: :not_found
  end

  def set_candidate
    @candidate = ClacbtCandidate.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Candidate not found" }, status: :not_found
  end

  def candidate_params
    params.require(:clacbt_candidate).permit(:email, :score)
  end
end
