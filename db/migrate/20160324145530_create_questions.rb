class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :survey, null: false, index: true
      t.string     :body,   null: false
      t.integer    :type,   null: false, default: 0, index: true
      t.timestamps          null: false
    end

    add_foreign_key :questions, :surveys
  end
end
