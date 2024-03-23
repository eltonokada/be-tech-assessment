module Api
  module V1
    class SessionsController < ApplicationController
      def create
        @session = Session.new(session_params)

        if @session.save
          render json: { session: @session }, status: :created
        else
          Rails.logger.error(@session.errors)
          render json: { errors: @session.errors }, status: :unprocessable_entity
        end
      end

      private

      def session_params
        params.require(:session).permit(:coach_hash_id, :client_hash_id, :start, :duration)
      end
    end
  end
end
