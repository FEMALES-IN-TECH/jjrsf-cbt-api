class Api::V1::ClacbtAnswersController < ApplicationController
  before_action :authenticate_token!, except: [:display_answer]
  before_action :set_question, only: [:index, :create]
  before_action :set_answer, only: [:show, :update, :destroy]

  def index
    # Fetch all answers for a specific question
    render json: @question.clacbt_answers
  end

  def show
    render json: @answer
  end

  def create
    answer = @question.clacbt_answers.build(answer_params)
    if answer.save
      render json: answer, status: :created
    else
      render json: answer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @answer.update(answer_params)
      render json: @answer, status: :ok
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy
    render json: { message: "Answer deleted successfully" }, status: :ok
  end

  def display_answer
    render json: ClacbtAnswer.find(params[:id]) # Public access to view an answer
  end

  private

  def set_question
    @question = ClacbtQuestion.find(params[:question_id])

    # Ensure the question belongs to an exam owned by the current user
    unless @question.clacbt_exam.clacbt_user == current_user
      render json: { error: "Unauthorized access" }, status: :forbidden
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Question not found" }, status: :not_found
  end

  def set_answer
    @answer = ClacbtAnswer.find(params[:id])

    # Ensure the answer belongs to a question in an exam owned by the user
    unless @answer.clacbt_question.clacbt_exam.clacbt_user == current_user
      render json: { error: "Unauthorized access" }, status: :forbidden
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Answer not found" }, status: :not_found
  end

  def answer_params
    params.require(:clacbt_answer).permit(:option, :answer_text, :correct)
  end
end
