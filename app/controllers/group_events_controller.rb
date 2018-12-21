class GroupEventsController < ApplicationController
  include ExceptionHandler
  prepend_before_action :validate_and_modify_jsonapi_params
  before_action :set_user, only: [:index, :create]
  before_action :set_group_event, only: [:show, :update, :destroy]

  deserializable_resource :group_event, class: DeserializableGroupEvent, only: [:create, :update]


  def index
    render jsonapi: @user.group_events.all,
           include: :user
  end

  def create
    @group_event = @user.group_events.new(group_event_params)
    if @group_event.save
      render jsonapi: @group_event, status: :created
    else
      render jsonapi_error: @group_event.errors, status: :bad_request
    end
  end

  def show
    render jsonapi: @group_event,
           include: :user
  end

  def update
    if @group_event.update(group_event_params)
      render jsonapi: @group_event, status: :ok
    else
      render jsonapi_error: @group_event.errors, status: :bad_request
    end
  end

  def destroy
    if @group_event.soft_delete!
      render jsonapi: @group_event, status: :ok
    else
      render jsonapi_error: @group_event.errors, status: :bad_request
    end
  end


  private

  def set_user
    @user = User.find(user_params[:user_id])
  end

  def user_params
    params.slice(:user_id).permit(:user_id)
  end

  def group_event_params
    params.require(:group_event)
          .except(:type, :user_id, :user_type)
          .permit(
            :description,
            :ends,
            :location,
            :name,
            :published,
            :starts
          )
  end

  def set_group_event
    @group_event = GroupEvent.where(user_id: params[:user_id]).find(params[:id])
  end
end