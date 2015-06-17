class AddDescriptionAndUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :description, :text, after: :username
    add_column :users, :url, :string, after: :description
  end
end
