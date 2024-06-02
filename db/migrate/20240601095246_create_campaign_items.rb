class CreateCampaignItems < ActiveRecord::Migration[7.1]
  def change
    create_table :campaign_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :campaign, null: false, foreign_key: true
      t.integer :quanitity_owned

      t.timestamps
    end
  end
end
