class Api::V1::ClacbtExamsController < ApplicationController
  before_action :authenticate_token!

  def index
    if current_user.present?
      render json: current_user.clacbt_exams
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end  

  def show
    exam = current_user.clacbt_exams.find(params[:id])  # Ensure user can only view their exams
    render json: exam
  end

  def create
    exam = current_user.clacbt_exams.build(exam_params)  # Assign exam to current user
    if exam.save
      render json: exam, status: :created
    else
      render json: exam.errors, status: :unprocessable_entity
    end
  end

  def update
    exam = current_user.clacbt_exams.find(params[:id])  # User can update only their exams
    if exam.update(exam_params)
      render json: exam, status: :ok
    else
      render json: exam.errors, status: :unprocessable_entity
    end
  end

  def destroy
    exam = current_user.clacbt_exams.find(params[:id])  # User can delete only their exams
    exam.destroy
    render json: exam, status: :ok
  end

  def display_exam
    skip_before_action :authenticate_token!, only: :display_exam
    exam = ClacbtExam.includes(clacbt_questions: :clacbt_answers).find_by(exam_code: params[:exam_code])
    if exam
      render json: exam, serializer: ClacbtExamSerializer
    else
      render json: { error: "Exam not found" }, status: :not_found
    end
  end 

  private

  def exam_params
    params.require(:clacbt_exam).permit(:name, :duration, :start_time, :end_time)
  end
end
