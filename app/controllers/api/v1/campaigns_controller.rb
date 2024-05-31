class Api::V1::CampaignsController < ApplicationController 
  def show
    campaign = Campaign.find(params[:id])
    render json: CampaignSerializer.new(campaign)
  end
end