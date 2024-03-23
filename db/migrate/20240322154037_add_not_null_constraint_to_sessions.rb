class AddNotNullConstraintToSessions < ActiveRecord::Migration[6.1]
  def change
    change_column_null :sessions, :start, false
    change_column_null :sessions, :duration, false
    change_column_null :sessions, :coach_hash_id, false
    change_column_null :sessions, :client_hash_id, false
  end
end