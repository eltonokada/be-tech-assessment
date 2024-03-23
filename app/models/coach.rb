class Coach < ApplicationRecord
  has_many :sessions, primary_key: :coach_hash_id, foreign_key: :coach_hash_id
end
