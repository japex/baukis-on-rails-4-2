class AppSetting < ActiveRecord::Base
  private_class_method :new, :create, :create!

  validates :application_name, presence: true, length: { maximum: 16 }
  validates :session_timeout_in_min, presence: true, \
                                     numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  DEFAULT_APPLICATION_NAME = 'BAUKIS'
  DEFAULT_SESSION_TIMEOUT_IN_MIN = 60

  def self.instance
    first || create!(
                      application_name:       DEFAULT_APPLICATION_NAME,
                      session_timeout_in_min: DEFAULT_SESSION_TIMEOUT_IN_MIN,
                    )
  end

  def self.application_name
    instance.application_name
  end

  def self.session_timeout_in_min
    instance.session_timeout_in_min
  end
end
