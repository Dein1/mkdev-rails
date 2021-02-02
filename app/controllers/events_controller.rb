# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_event, only: %i[show edit update destroy]
  before_action :check_user, only: %i[edit update destroy]

  def index
    @events = Event.order(created_at: :desc).page(params[:page])
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new(event_params)

    if @event.save
      redirect_to events_path, success: t(:was_created)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to events_path, success: t(:was_edited)
    else
      render :edit
    end
  end

  def destroy
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

  def find_event
    @event = Event.find(params[:id])
  end

  def check_user
    return if @event.author == current_user

    redirect_to events_path, warning: t(:no_rights)
  end
end
