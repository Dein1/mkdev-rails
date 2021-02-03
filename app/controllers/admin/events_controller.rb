# frozen_string_literal: true

class Admin
  class EventsController < Admin::BaseController
    def index
      @events = Event.order(created_at: :desc).page(params[:page])
    end

    def edit
      @event = Event.find(params[:id])
    end

    def update
      @event = Event.find(params[:id])

      if @event.update(event_params)
        redirect_to admin_events_path, success: t(:was_edited)
      else
        render :edit
      end
    end

    def destroy
      @event = Event.find(params[:id])

      @event.destroy

      redirect_to admin_events_path, warning: t(:was_deleted)
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
end
