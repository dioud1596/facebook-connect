class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :token
      t.datetime :token_expiry
      t.belongs_to :user

      t.timestamps
    end
  end
end
