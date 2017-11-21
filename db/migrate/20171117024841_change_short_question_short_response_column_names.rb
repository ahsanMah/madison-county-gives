class ChangeShortQuestionShortResponseColumnNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :short_questions, :text, :question
    rename_column :short_responses, :text, :response
  end
end
