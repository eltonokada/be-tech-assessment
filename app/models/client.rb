class Client < ApplicationRecord
  has_many :sessions, primary_key: :client_hash_id, foreign_key: :client_hash_id 
end
