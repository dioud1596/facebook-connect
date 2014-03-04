class AddFbInfosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_id, :string
    add_column :users, :picture_url, :string
    add_column :users, :user_name, :string
    
  end
end
