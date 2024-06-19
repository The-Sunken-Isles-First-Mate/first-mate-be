class Api::V1::UsersController < ApplicationController
  def show
    user = User.find_or_create_by(uid: params[:id]) do |user|
      user.username = params[:user][:username]
    end
    user.save!
    render json: UserSerializer.new(user)
  end

  # def show
  #   if (username = params[:user][:username]) && (token = params[:user][:token])
  #     user = User.find_or_create_by(uid: params[:id])
  #     user.username = username.downcase
  #     user.uid = params[:id]
  #     user.token = token
  #     user.save
  #     render json: UserSerializer.new(user)
  #   else
  #     render json: { errors: [{status: '400', title:'Username or Token cannot be missing' }]},
  #     status: :bad_request
  #   end
  # end
end
