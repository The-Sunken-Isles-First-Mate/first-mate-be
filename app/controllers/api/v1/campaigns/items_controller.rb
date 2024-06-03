class Api::V1::Campaigns::ItemsController < ApplicationController
  def index
    #binding.pry
    campaign = Campaign.find(params[:id])
    items = campaign.items
    render json: ItemSerializer.new(items)
  end

end