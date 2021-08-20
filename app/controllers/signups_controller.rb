class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    def create
        # byebug
    signup = Signup.create!(signup_params)
    render json: signup.activity, status: :created
    end

    private

    def signup_params
        params.require(:singup).permit(:time, :camper_id, :activity_id)
    end

    def render_unprocessable_entity_response(invalid)
        # byebug
        # render json: {errors: "#{invalid.message}"}, status: :unprocessable_entity
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
