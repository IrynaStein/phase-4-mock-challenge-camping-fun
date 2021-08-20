class ActivitiesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    def index
        render json: Activity.all
    end

    def destroy
        # byebug
        activity = Activity.find(params[:id])
        activity.destroy
        # head :no_content
        render json: {}
    end

    private 

    def render_not_found_response(exception)
    # byebug
        # render json: { errors: "#{exception.model} not found" }, status: :not_found
        render json: { error: "#{exception.model} not found" }, status: :not_found
      end
    
end
