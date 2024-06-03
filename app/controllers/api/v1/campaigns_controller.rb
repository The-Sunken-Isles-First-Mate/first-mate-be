class Api::V1::CampaignsController < ApplicationController 
  def show
    campaign = Campaign.find(params[:id])
    render json: CampaignSerializer.new(campaign)
  end

  def create
    campaign = Campaign.new(campaign_params)

    if campaign.save!

      # Create campaign items for pre-made items
      Item.all.each do |item|
        campaign.campaign_items.create(item_id: item.id)
      end
      
      render json: CampaignSerializer.new(campaign), status: 201
    # else
    #   render json: campaign.errors, status: :unprocessable_entity
    end
    # campaign.save!
    # render json: CampaignSerializer.new(campaign), status: 201
  end

  def update
    campaign = Campaign.find(params[:id])
    campaign.update!(campaign_params)
    render json: CampaignSerializer.new(campaign), status: 200
  end

  private
  def campaign_params
    params.require(:campaign)
          .permit(:name, 
                  :week, 
                  :animal_products, 
                  :cloth, 
                  :farmed_goods, 
                  :food, 
                  :foraged_goods, 
                  :metal, 
                  :monster_parts, 
                  :stone, 
                  :wood, 
                  :villagers)
  end
end