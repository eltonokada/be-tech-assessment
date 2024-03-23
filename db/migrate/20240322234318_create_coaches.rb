class CreateCoaches < ActiveRecord::Migration[6.1]
  def change
    create_table :coaches do |t|
      t.string :coach_hash_id
      t.timestamps
    end
  end
end
