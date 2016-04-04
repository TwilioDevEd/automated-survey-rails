class AddCallSidToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :call_sid, :string, default: ''
    add_index :answers, :call_sid
  end
end
