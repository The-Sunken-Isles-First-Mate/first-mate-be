class AddDefaultToQuantityOwnedInCampaignItems < ActiveRecord::Migration[7.1]
  def change
    change_column_default :campaign_items, :quantity_owned, 0
  end
end
