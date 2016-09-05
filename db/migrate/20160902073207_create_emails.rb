class CreateEmails < ActiveRecord::Migration

  def change
    create_table :emails do |t|
      t.references :customer       , null: false
      t.string     :email          , null: false
      t.string     :email_for_index, null: false  # for DB index

      t.timestamps null: false
    end

    add_index :emails, :email_for_index, unique: true
  end
end
