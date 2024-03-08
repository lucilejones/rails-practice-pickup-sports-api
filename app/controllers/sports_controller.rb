class SportsController < ApplicationController
    before_action :authenticate_request
    
    def index
      sports = Sport.all
      render json: SportBlueprint.render(sports), status: :ok
    end
  end