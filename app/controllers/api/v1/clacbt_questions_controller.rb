class Api::V1::ClacbtQuestionsController < ApplicationController
  before_action :authenticate_token!, except: [:display_question]
  before_action :set_exam, only: [:index, :create]
  before_action :set_question, only: [:show, :update, :destroy]

  def index
    # Fetch only questions that belong to the exam
    render json: @exam.clacbt_questions
  end

  def show
    render json: @question
  end

  def create
    question = @exam.clacbt_questions.build(question_params)
    if question.save
      render json: question, status: :created
    else
      render json: question.errors, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      render json: @question, status: :ok
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    render json: { message: "Question deleted successfully" }, status: :ok
  end

  def display_question
    render json: ClacbtQuestion.find(params[:id])  # Publicly accessible
  end

  private

  def set_exam
    @exam = current_user.clacbt_exams.find(params[:exam_id])  # Ensure user owns the exam
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Exam not found or unauthorized" }, status: :forbidden
  end

  def set_question
    @question = ClacbtQuestion.find(params[:id])
    unless @question.clacbt_exam.clacbt_user == current_user  # Ensure user owns the exam
      render json: { error: "Unauthorized access" }, status: :forbidden
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Question not found" }, status: :not_found
  end

  def question_params
    params.require(:clacbt_question).permit(:question, :option_a, :option_b, :option_c, :option_d, :answer)
  end
end
