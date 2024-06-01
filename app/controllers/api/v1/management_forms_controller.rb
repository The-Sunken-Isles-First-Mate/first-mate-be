class Api::V1::ManagementFormsController < ApplicationController
  def show
    Campaign.find(find_form_params[:campaign_id])
    management_form = ManagementForm.find_by(find_form_params)
    render json: ManagementFormSerializer.new(management_form)
  end

  private
  def find_form_params
    params.require(:management_form).permit(:campaign_id, :week)
  end
end
