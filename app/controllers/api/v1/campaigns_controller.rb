class Api::V1::CampaignsController < ApplicationController 
  def show
    campaign = Campaign.find(params[:id])
    render json: CampaignSerializer.new(campaign)
  end

  def create
    campaign = Campaign.new(campaign_params)
    campaign.save!
    render json: CampaignSerializer.new(campaign), status: 201
  end

  def update
    campaign = Campaign.find(params[:id])
    campaign.update!(campaign_params)
    render json: CampaignSerializer.new(campaign), status: 200
  end

  def advance_week
    campaign = Campaign.find(params[:campaign_id])
    management_form = ManagementForm.new(management_form_params)
    if management_form.save
      campaign.update!(week: campaign.week + 1)
      update_campaign_resources(campaign, management_form)
      subtract_item_costs(campaign, management_form)
      create_new_management_form(campaign)
      update_campaign_items_quantity(management_form)
      render json: CampaignSerializer.new(campaign), status: 200
    else
      render json: { error: management_form.errors.full_messages }, status: 422
    end
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
                  :villagers
                 )
  end

  def management_form_params
    params.require(:campaign)
          .permit(:campaign_id, :week, :animal_products, :cloth, :farmed_goods, :food, :foraged_goods, 
                  :metal, :monster_parts, :stone, :wood, :light_armor, :medium_armor, 
                  :heavy_armor, :simple_weapon, :martial_weapon, :ammunition, :adventuring_supplies, 
                  :assassins_blood, :malice, :midnight_tears, :serpent_venom, :truth_serum, 
                  :oil_of_slipperiness, :potion_of_climbing, :potion_of_healing, :potion_of_water_breathing, 
                  :barge, :coracle, :double_hulled_sailing_canoe, :keelboat, :raft, 
                  :single_hulled_sailing_canoe, :ballista, :cabin, :magical_defenses, :storage
                 )
  end

  def update_campaign_resources(campaign, management_form)
    resource_attributes = %i[animal_products cloth farmed_goods food foraged_goods metal monster_parts stone wood]

    resource_attributes.each do |attr|
      next if management_form[attr].zero?

      campaign[attr] += (management_form[attr] / 10)
    end

    campaign.save!
  end

  def subtract_item_costs(campaign, management_form)
    management_form.attributes.each do |key, value|
      next unless value.is_a?(Integer) && value > 0

      item = Item.find_by(name: key.humanize)
      next unless item

      item_cost_attributes = %i[animal_products_cost cloth_cost farmed_goods_cost food_cost foraged_goods_cost metal_cost stone_cost wood_cost monster_parts_cost]

      item_cost_attributes.each do |cost_attr|
        resource_attr = cost_attr.to_s.gsub('_cost', '').to_sym
        campaign[resource_attr] -= item[cost_attr] * value if campaign[resource_attr]
      end
    end

    campaign.save!
  end

  def create_new_management_form(campaign)
    ManagementForm.create!(
      campaign_id: campaign.id,
      week: campaign.week
    )
  end

  def update_campaign_items_quantity(management_form)
    item_attributes = %i[light_armor medium_armor heavy_armor simple_weapon martial_weapon ammunition adventuring_supplies assassins_blood malice midnight_tears serpent_venom truth_serum oil_of_slipperiness potion_of_climbing potion_of_healing potion_of_water_breathing barge coracle double_hulled_sailing_canoe keelboat raft single_hulled_sailing_canoe ballista cabin magical_defenses storage]

    item_attributes.each do |attr|
      item = Item.find_by(name: attr.to_s.humanize)
      next unless item
      item_id = item.id
      campaign_id = management_form.campaign_id
      
      campaign_item = CampaignItem.find_by(item_id: item_id, campaign_id: campaign_id)

      prev_quant_owned = campaign_item.quantity_owned
      campaign_item.update!(quantity_owned: prev_quant_owned += management_form[attr])
    end
  end
end