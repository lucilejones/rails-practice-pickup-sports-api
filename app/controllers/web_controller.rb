class WebController < ApplicationController
  before_action :authenticate_request

  def bootstrap
    render json: {
      current_user: UserBlueprint.render_as_hash(@current_user, view: :me)
    }, status: :ok
  end
end
