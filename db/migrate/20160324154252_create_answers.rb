class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question, null: false, index: true
      t.integer    :source,   null: false, default: 0, index: true
      t.string     :content,  null: false
      t.string     :from,     null: false, index: true
      t.timestamps            null: false
    end

    add_foreign_key :answers, :questions
  end
end
