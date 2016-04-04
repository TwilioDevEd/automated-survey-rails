class CreateTranscriptions < ActiveRecord::Migration
  def change
    create_table :transcriptions do |t|
      t.belongs_to :answer, index: true
      t.string :text, default: ''
      t.timestamps null:false
    end
  end
end
