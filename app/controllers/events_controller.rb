class EventsController < ApplicationController
    before_action :set_event, only: [:show, :update, :destroy]
    # before_action :authenticate_request, except: [:index]
    before_action :authenticate_request

    # def index
    #     events = Event.all
    #     render json: events, status: :ok
    # end
    
    def index
        events = Event.order(created_at: :desc).page(params[:page]).per(12)
    
        render json: {
            events: EventBlueprint.render_as_hash(events, view: :short),
            total_pages: events.total_pages,
            current_page: events.current_page
        }
    end

    def show
        # render json: @event, status: :ok
        render json: EventBlueprint.render_as_hash(@event, view: :long, current_user: @current_user), status: :ok
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

    def join
        event = Event.find(params[:event_id])
    
        # check if the current user is the event creator
        return render json: {error: "You can't join your own event."}, status: :unprocessable_entity if event.creator.id == @current_user.id
    
        # check if the event is full
        return render json: {error: "Event is full."}, status: :unprocessable_entity if event.participants.count >= event.guests
    
        # check if the current user is already a participant
        return render json: {error: "You are already a participant."}, status: :unprocessable_entity if event.participants.include?(@current_user)
    
        event.participants << @current_user

        Pusher.trigger(event.creator.id, 'notification', {
            event_id: event.id,
            notification: "#{@current_user.username} has joined #{event.title}!"
        })
    
        head :ok
    end

    def leave
        event = Event.find(params[:event_id])
    
        event.participants.delete(@current_user)

        Pusher.trigger(event.creator.id, 'notification', {
            event_id: event.id,
            notification: "#{@current_user.username} has left #{event.title}!"
        })

        head :ok
    end

    private
    
    def set_event
        @event = Event.find(params[:id])
    end

    def event_params
        params.permit(:title, :content, :start_date_time, :end_date_time, :guests, :cover_image, :sport_ids => [])
    end
end
