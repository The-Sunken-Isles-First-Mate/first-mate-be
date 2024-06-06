class Api::V1::UserCampaignsController < ApplicationController
  def create
    user_campaign = UserCampaign.new(user_campaign_params)
    user_campaign.save!
    render json: UserCampaignSerializer.new(user_campaign), status: 201
  end

  def index
    user = User.find(params[:user_id])
    campaigns = user.user_campaigns
    render json: UserCampaignSerializer.new(campaigns)
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
