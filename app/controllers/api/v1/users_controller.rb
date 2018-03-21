class Api::V1::UsersController < ApplicationController
  # before_action :authenticate_user!, only: [:show, :update, :destroy]
  before_action :authenticate_with_token!, only: [:show, :update, :destroy]
  before_action :set_user, only: [:show, :update, :destroy]
  respond_to :json

  # GET /users
  def index
    # @users = User.filter(params)
    # @users = User.all
    # render json: @users
  end

  # GET /users/1
  def show
    if @user == current_user
      render json: @user, location: [:api, @user]
    else
      redirect_to :back, :alert => "Access denied."
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: [:api, @user]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user, location: [:api, @user]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    head 204
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def query_params
      params.permit(:user_ids, :first_name, :last_name)
    end
end