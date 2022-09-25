class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_event, only: %i[edit destroy show update]
  after_action :verify_authorized, except: %i[index]
  after_action :verify_policy_scoped, only: %i[index]

  def index
    @events = policy_scope(Event)
  end

  def show
    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end

    authorize(@event)

    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  end

  def new
    authorize(Event)
    @event = current_user.events.build
  end

  def edit
    authorize(@event)
  end

  def create
    @event = current_user.events.build(event_params)

    authorize(@event)

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    authorize(@event)

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: I18n.t('controllers.events.destroyed')
  end

  private

  def user_not_authorized
    unless policy(@event).show?
      flash.now[:alert] = t('controllers.events.wrong_pincode') if params[:pincode].present?
      render 'password_form'
    else
      super
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end
end
