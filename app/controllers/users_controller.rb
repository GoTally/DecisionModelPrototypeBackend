class UsersController < ApplicationController

  def index
    @users = User.all

    if params[:first_name] && params[:last_name]
      @users = @users.where(first_name: params[:first_name], last_name: params[:last_name])
    end

    render json: @users, status: 200, callback: params[:callback]
  end

  def show
    @user = User.find_by_id(params[:id])
    if params[:polls]
      render json: @user.to_json(include: :polls), status: 200, callback: params[:callback]
    else
      render json: @user, status: 200, callback: params[:callback]
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: 201, callback: params[:callback]
    else
      render json: @user.errors, status: 422, callback: params[:callback]
    end
  end

private

  def user_params
    params.permit(:first_name, :last_name, :age, :gender)
  end
end
