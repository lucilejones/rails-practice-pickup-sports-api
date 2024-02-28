class EventsController < ApplicationController
    before_action :set_event, only: [:show, :update, :destroy]
    before_action :authenticate_request

    def index
        events = Event.all
        render json: events, status: :ok
    end

    def show
        render json: @event, status: :ok
    end

    def create
        # event = Event.new(event_params)
        event = @current_user.created_events.new(event_params)

        if event.save
            render json: event, status: :created
        else
            render json: event.errors, status: :unprocessable_entity
        end
    end

    def update
        if @event.update(event_params)
            render json: @event, status: :ok
        else
            render json: @event.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if@event.destroy
            render json: nil, status: :ok
        else
            render json: @event.errors, status: :unprocessable_entity
        end
    end

    private
    
    def set_event
        @event = Event.find(params[:id])
    end

    def event_params
        params.permit(:title, :content, :start_date_time, :end_date_time, :guests, :sport_ids => [])
    end
end
