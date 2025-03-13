class CandidateMailer < ApplicationMailer
  default from: 'no-reply@yourapp.com'  # Set your sender email

  def candidate_updated(candidate)
    @candidate = candidate
    @exam = candidate.clacbt_exam
    @exam_owner = @exam.clacbt_user  # Assuming the exam has a user relationship

    mail(
      to: @candidate.email,  
      cc: @exam_owner.email,  
      subject: "Your Exam Results for #{@exam.name}"
    )
  end
end
