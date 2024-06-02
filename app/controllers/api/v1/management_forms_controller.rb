class Api::V1::ManagementFormsController < ApplicationController
  def show
    if (campaign_id = find_form_params[:campaign_id]) && (week = find_form_params[:week])
      campaign = Campaign.find(campaign_id)

      if week.to_i.between?(0, campaign.week)
        management_form = ManagementForm.find_by(find_form_params)
        render json: ManagementFormSerializer.new(management_form)
      else
        render json: { errors: [{status: '400', title:'Week cannot be less than 0 or greater than the campaign week' }]},
        status: :bad_request
      end
    else
      render json: { errors: [{status: '400', title:'Campaign ID or Week cannot be missing' }]},
      status: :bad_request
    end
  end

  def update
    form = ManagementForm.find(params[:id])
    form.update!(form_params)
    render json: ManagementFormSerializer.new(form), status: 200
  end

  private
  def find_form_params
    params.require(:management_form).permit(:campaign_id, :week)
  end

  def form_params
    params.require(:management_form).permit(
      :animal_products,
      :cloth,
      :farmed_goods,
      :food,
      :foraged_goods,
      :metal,
      :monster_parts,
      :stone,
      :wood,
      :light_armor,
      :medium_armor,
      :heavy_armor,
      :simple_weapon,
      :martial_weapon,
      :ammunition,
      :adventuring_supplies,
      :assassins_blood,
      :malice,
      :midnight_tears,
      :serpent_venom,
      :truth_serum,
      :oil_of_slipperiness,
      :potion_of_climbing,
      :potion_of_healing,
      :potion_of_water_breathing,
      :barge,
      :coracle,
      :double_hulled_sailing_canoe,
      :keelboat,
      :raft,
      :single_hulled_sailing_canoe,
      :ballista,
      :cabin,
      :magical_defenses,
      :storage
      )
  end
end
