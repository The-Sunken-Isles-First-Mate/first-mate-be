class Api::V1::UsersController < ApplicationController
  def show
    if params[:user][:password]
      user = User.find_or_create_by(uid: params[:id]) do |user|
        user.username = params[:user][:username]
        user.password = params[:user][:password]
      end
      user.save!
    else
      user = User.find_or_create_by(uid: params[:id]) do |user|
        user.username = params[:user][:username]
        user.password = SecureRandom.base64.tr('+/=', 'Qrt')
      end
      user.save!
    end

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
