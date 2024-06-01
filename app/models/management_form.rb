class ManagementForm < ApplicationRecord
  belongs_to :campaign

  validate :week_must_be_equal_or_less_than_campaign_week

  private

  def week_must_be_equal_or_less_than_campaign_week
    if week < campaign.week
      errors.add(:week, "must be equal to or greater than the campaign week")
    end
  end
end
