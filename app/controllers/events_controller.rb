class EventsController < ApplicationController
  def index
    @events = Event.order(created_at: :desc).page(params[:page])
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_path, success: t(:was_created)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to events_path, success: t(:was_edited)
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path, warning: t(:was_deleted)
  end

  private
    def event_params
      params.require(:event).permit :title,
                                    :description,
                                    :location,
                                    :start_time,
                                    :end_time,
                                    :organizer_email,
                                    :organizer_telegram,
                                    :link
    end
end
