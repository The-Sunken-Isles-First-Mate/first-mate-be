class Api::V1::ItemsController < ApplicationController 
  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def index
    campaign = Campaign.find(params[:campaign_id])
    items = campaign.items
    render json: ItemSerializer.new(items)
  end
end