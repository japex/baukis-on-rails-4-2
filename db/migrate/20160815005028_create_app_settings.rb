class CreateAppSettings < ActiveRecord::Migration

  def change
    create_table :app_settings do |t|
      t.string  :application_name
      t.integer :session_timeout_in_min

      t.timestamps null: false
    end
  end
end
