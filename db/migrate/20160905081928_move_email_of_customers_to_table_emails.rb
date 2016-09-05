class MoveEmailOfCustomersToTableEmails < ActiveRecord::Migration

  def up
    execute(%q{
      INSERT INTO emails
        (customer_id, email, email_for_index, created_at, updated_at)
        SELECT id, email, email_for_index, now(), now()
          FROM customers
    })

    remove_column :customers, :email
    remove_column :customers, :email_for_index
  end

  def down
    add_column :customers, :email          , :string, null: false
    add_column :customers, :email_for_index, :string, null: false

    execute(%q{
      UPDATE customers c, emails e
        SET c.email = e.email, c.email_for_index = e.email_for_index
        WHERE c.id = e.customer_id
    })

    add_index :customers, :email_for_index, unique: true

    execute(%q{
      DELETE FROM emails
    })
  end
end
