class ShortResponse < ApplicationRecord
  belongs_to :short_question
  belongs_to :organization

  validates :response, :presence => true
end
