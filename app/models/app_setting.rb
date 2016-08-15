class AppSetting < ActiveRecord::Base

  def self.application_name
    order(:updated_at).last.application_name
  end
end
