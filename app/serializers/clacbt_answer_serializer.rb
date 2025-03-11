class ClacbtAnswerSerializer < ActiveModel::Serializer
  attributes :id, :option, :answer_text, :correct
end
