class ShortResponse < ApplicationRecord
  belongs_to :short_question
  belongs_to :organization
end
