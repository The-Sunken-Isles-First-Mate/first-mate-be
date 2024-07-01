class Api::V1::UserCampaignsController < ApplicationController
  def create
    user_campaign = UserCampaign.new(user_campaign_params)

    if params[:user_campaign][:username]
      invited_user = User.find_by(username: params[:user_campaign][:username].downcase)
      user_campaign.user_id = invited_user.id
    end

    user_campaign.save!
    render json: UserCampaignSerializer.new(user_campaign), status: 201
  end

  def index
    if user = User.find_by(uid: params[:user_id])
      campaigns = user.user_campaigns
      render json: UserCampaignSerializer.new(campaigns)
    else
      render json: { errors: [{status: '400', title:"Couldn't find that user" }]},
        status: :bad_request
    end
  end

  def update
    user_campaign = UserCampaign.find(params[:id])
    user_campaign.update!(user_campaign_params)
    render json: UserCampaignSerializer.new(user_campaign), status: 200
  end

  private
  def user_campaign_params
    params.require(:user_campaign)
          .permit(:user_id,
                  :campaign_id,
                  :character_id,
                  :role
                  )
  end
end
