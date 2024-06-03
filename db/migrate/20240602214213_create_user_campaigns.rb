class CreateUserCampaigns < ActiveRecord::Migration[7.1]
  def change
    create_table :user_campaigns do |t|
      t.integer :role, default: 0
      t.references :character, foreign_key: true
      t.references :campaign, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
