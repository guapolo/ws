class UsersController < ApplicationController
  include ExceptionHandler

  def index
    @users = User.all
    render jsonapi: @users
  end

  def show
    @user = User.includes(:group_events).find(params[:id])
    render jsonapi: @user,
           include: :group_events,
           fields: { group_events: [:name, :starts, :ends] }
  end
end
