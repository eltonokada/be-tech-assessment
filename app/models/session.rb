class Session < ApplicationRecord
  belongs_to :coach, primary_key: :coach_hash_id, foreign_key: :coach_hash_id
  belongs_to :client, primary_key: :client_hash_id, foreign_key: :client_hash_id
  
  validates :start, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :coach_hash_id, presence: true
  validates :client_hash_id, presence: true

  validates_with OverlappingSessionsValidator, on: :create

end