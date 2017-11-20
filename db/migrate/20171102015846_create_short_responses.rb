class CreateShortResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :short_responses do |t|
      t.integer :short_question_id
      t.integer :organization_id
      t.text :text

      t.timestamps
    end
  end
end
