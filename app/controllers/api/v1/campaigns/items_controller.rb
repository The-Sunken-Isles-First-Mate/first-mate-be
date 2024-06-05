class Api::V1::Campaigns::ItemsController < ApplicationController
  def index
    #binding.pry
    campaign = Campaign.find(params[:id])
    items = campaign.campaign_items
    render json: CampaignItemSerializer.new(items)
  end

end
