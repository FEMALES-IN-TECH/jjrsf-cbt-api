class ClacbtExam < ActiveRecord::Base
  belongs_to :clacbt_user
  has_many :clacbt_questions
  has_many :clacbt_candidates

  validates :name, presence: true
  validates :duration, numericality: { greater_than: 0 }
  validates :start_time, :end_time, presence: true
  validates :exam_code, presence: true, uniqueness: true, length: { is: 6 }, format: { with: /\A[a-z0-9]{6}\z/ }

  before_validation :generate_exam_code, on: :create

  private

  def generate_exam_code
    self.exam_code ||= loop do
      random_code = SecureRandom.alphanumeric(6).downcase
      break random_code unless ClacbtExam.exists?(exam_code: random_code)
    end
  end
end