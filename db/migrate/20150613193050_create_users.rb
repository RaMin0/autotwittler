class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username, index: true
      t.string :twitter_uid, index: true
      t.string :twitter_access_token
      t.string :twitter_access_token_secret

      t.timestamps null: false
    end
  end
end
