# app/validators/overlapping_sessions_validator.rb
class OverlappingSessionsValidator < ActiveModel::Validator
  def validate(record)
    overlapping_sessions = Session.where(coach_hash_id: record.coach_hash_id)
                                  .where("(? < datetime(start, '+' || duration || ' minutes')) AND (start < ?) ",
                                  record.start, 
                                  record.start + record.duration.minutes)
    
    if overlapping_sessions.any?
      record.errors.add(:base, 'Session overlaps with another session')
    end
  end
end