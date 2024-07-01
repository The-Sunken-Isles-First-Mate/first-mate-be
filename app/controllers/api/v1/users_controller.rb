class Api::V1::UsersController < ApplicationController
  def index
    user = User.find_by(username: params[:user][:username])

    if user.authenticate(params[:user][:password])
      render json: UserSerializer.new(user)
    else
      render json: { error: "Incorrect credentials" }
    end
  end

  def show
    if params[:user][:password]
      user = User.find_or_create_by(uid: params[:id]) do |user|
        user.username = params[:user][:username].downcase
        user.password = params[:user][:password]
      end
      user.save!
    else
      user = User.find_or_create_by(uid: params[:id]) do |user|
        user.username = params[:user][:username].downcase
        user.password = SecureRandom.base64.tr('+/=', 'Qrt')
      end
      user.save!
    end

    render json: UserSerializer.new(user)
  end
end
