class CreateShortQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :short_questions do |t|
      t.text :question

      t.timestamps
    end
  end
end
