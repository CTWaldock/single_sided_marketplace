class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :activate]

  def new
    @user = User.new
  end

  def index
    @user = User.all
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'user was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # @user.destroy
    @user.deactivated = !@user.deactivated
    @user.save
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully deactivated.' }
      format.json { head :no_content }
    end
  end
  
  def activate_toggle
    if deactivated
      update_attributes(deactivated: false) 
    end
    if !deactivated
      update_attributes(deactivated: true)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :email)
  end
end
