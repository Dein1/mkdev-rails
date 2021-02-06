# frozen_string_literal: true

class Admin
  class EventsController < Admin::BaseController
    def index
      @events = Event.where(state: %i[approved rejected]).order(created_at: :desc).page(params[:page])
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

    def pending
      @events = Event.where(state: :pending).order(created_at: :desc).page(params[:page])
    end

    def approve
      @event = Event.find(params[:event_id])

      @event.approve!

      redirect_to pending_admin_events_path, success: t(:was_approved)
    end

    def reject
      @event = Event.find(params[:event_id])

      @event.reject!

      redirect_to pending_admin_events_path, warning: t(:was_rejected)
    end

    private

    def event_params
      params.require(:event).permit!
    end
  end
end
