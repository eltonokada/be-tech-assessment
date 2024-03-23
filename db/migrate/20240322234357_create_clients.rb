class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :client_hash_id
      t.timestamps
    end
  end
end
