class ClacbtQuestion < ApplicationRecord
    belongs_to :clacbt_exam
    has_many :clacbt_answers
end  