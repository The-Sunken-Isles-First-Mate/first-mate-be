class Api::V1::CampaignItemsController < ApplicationController 
  def create
    campaign_item = CampaignItem.new(campaign_item_params)
    campaign_item.save!
    render json: CampaignItemSerializer.new(campaign_item), status: 201
  end

  private

  def campaign_item_params
    params.require(:campaign_item).permit(:item_id, :campaign_id, :quantity_owned)
  end

end