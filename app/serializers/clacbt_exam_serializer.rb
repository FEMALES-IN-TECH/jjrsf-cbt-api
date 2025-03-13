class ClacbtExamSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :start_time, :end_time, :exam_code
end
