class ClacbtQuestionSerializer < ActiveModel::Serializer
  attributes :id, :question, :mark

  has_many :clacbt_answers, serializer: ClacbtAnswerSerializer
end
