class CreateShortQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :short_questions do |t|
      t.text :text

      t.timestamps
    end
  end
end
