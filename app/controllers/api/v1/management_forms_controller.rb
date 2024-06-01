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

  private
  def find_form_params
    params.require(:management_form).permit(:campaign_id, :week)
  end
end
