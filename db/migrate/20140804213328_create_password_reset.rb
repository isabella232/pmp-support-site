class CreatePasswordReset < ActiveRecord::Migration
  def change
    create_table :password_resets do |t|
      t.string :token
      t.string :email_address
      t.string :user_name
      t.string :user_guid
      t.string :host
      t.timestamps
    end
  end
end
