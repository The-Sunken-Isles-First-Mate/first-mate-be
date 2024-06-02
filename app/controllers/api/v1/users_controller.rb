class Api::V1::UsersController < ApplicationController
  def show
    user          = User.find_or_create_by(uid: params[:id])
    user.username = params[:user][:username]
    user.uid      = params[:id]
    user.token    = params[:user][:token]
    user.save
    render json: UserSerializer.new(user)
  end
end
