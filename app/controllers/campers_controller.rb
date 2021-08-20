class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_response

  def index
    render json: Camper.all
  end

  def show
    camper = find_camper
    render json: camper, include: [:activities]
  end

  def create
    # byebug
    camper = Camper.create!(camper_params)
    render json: camper, status: :created
  end

  private

  def find_camper
    Camper.find(params[:id])
  end

  def camper_params
    params.require(:camper).permit(:name, :age)
  end

  def render_not_found_response(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end

  def render_invalid_record_response(invalid)
    # byebug
    # render json: {errors: "#{invalid.message.split(': ')[1]}"}, status: :unprocessable_entity
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    
  end
end
