class SubscriptionsController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_subscription, only: %i[destroy]

  def create
    @subscription = Subscription.new(subscription_params)
    
    if @subscription.save
      redirect_to @subscription, notice: I18n.t('controllers.subscriptions.created')
    else
      render :new
    end
  end

  def destroy
    @subscription.destroy
    redirect_to subscription_url, notice: I18n.t('controllers.subscriptions.deleted')
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
