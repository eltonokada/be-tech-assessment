# spec/models/session_spec.rb
require 'rails_helper'

RSpec.describe Session, type: :model do
  describe 'validations' do

    before do
      @coach = FactoryBot.create(:coach, coach_hash_id: '123')
      @client = FactoryBot.create(:client, client_hash_id: '456')
    end

    it 'should validate overlapping sessions on create' do
      session = FactoryBot.create(:session, start: Time.now, duration: 60, coach_hash_id: @coach.coach_hash_id, client_hash_id: @client.client_hash_id  )

      overlapping_session = FactoryBot.build(:session, start: Time.now - 30.minutes, duration: 90, coach_hash_id: @coach.coach_hash_id, client_hash_id: @client.client_hash_id  )

      expect(overlapping_session).not_to be_valid

      expect(overlapping_session.errors[:base]).to include('Session overlaps with another session')
    end

    it 'should return valid for a record that starts as soon as the other ends' do
      session = FactoryBot.create(:session, start: Time.now, duration: 60, coach_hash_id: @coach.coach_hash_id, client_hash_id: @client.client_hash_id  )
      new_session = FactoryBot.create(:session, start: Time.now+60.minutes, duration: 60, coach_hash_id: @coach.coach_hash_id, client_hash_id: @client.client_hash_id  )

      expect(new_session).to be_valid
    end

    it 'should return valid for a record that ends right before the other start' do
      session = FactoryBot.create(:session, start: Time.now, duration: 60, coach_hash_id: @coach.coach_hash_id, client_hash_id: @client.client_hash_id  )
      new_session = FactoryBot.create(:session, start: Time.now-120.minutes, duration: 119, coach_hash_id: @coach.coach_hash_id, client_hash_id: @client.client_hash_id  )

      expect(new_session).to be_valid
    end

    it 'should return invalid for a record that ends after 1 minute than other started' do
      session = FactoryBot.create(:session, start: Time.now, duration: 60, coach_hash_id: @coach.coach_hash_id, client_hash_id: @client.client_hash_id  )
      new_session = FactoryBot.build(:session, start: Time.now-60.minutes, duration: 61, coach_hash_id: @coach.coach_hash_id, client_hash_id: @client.client_hash_id  )
    
      expect(new_session).not_to be_valid
      expect(new_session.errors[:base]).to include('Session overlaps with another session')
    end

    it 'should validate overlapping sessions on create for different coaches' do
      FactoryBot.create(:session, start: Time.now, duration: 60, coach_hash_id: @coach.coach_hash_id, client_hash_id: @client.client_hash_id  )
      coach2 = FactoryBot.create(:coach, coach_hash_id: '456')
      overlapping_session = FactoryBot.build(:session, start: Time.now + 30.minutes, duration: 60, coach_hash_id: coach2.coach_hash_id, client_hash_id: @client.client_hash_id  ) 
      expect(overlapping_session).to be_valid
    end

  end
end