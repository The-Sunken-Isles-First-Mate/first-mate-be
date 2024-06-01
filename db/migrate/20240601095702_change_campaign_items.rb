class ChangeCampaignItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :campaign_items, :quanitity_owned, :integer
    add_column :campaign_items, :quantity_owned, :integer
  end
end
