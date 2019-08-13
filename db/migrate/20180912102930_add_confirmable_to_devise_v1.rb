class AddConfirmableToDeviseV1 < ActiveRecord::Migration[5.2]
   def self.up
    add_column :admins, :confirmation_token,   :string
    add_column :admins, :confirmed_at,         :datetime
    add_column :admins, :confirmation_sent_at, :datetime
    add_column :admins, :unconfirmed_email,    :string

    add_index  :admins, :confirmation_token, :unique => true
  end

  def self.down
    remove_index  :admins, :confirmation_token

    remove_column :admins, :unconfirmed_email
    remove_column :admins, :confirmation_sent_at
    remove_column :admins, :confirmed_at
    remove_column :admins, :confirmation_token
  end
end
