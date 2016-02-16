class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :name
      t.integer :uid
      t.string :provider
      t.string :image_url
      t.string :token

      t.timestamps null: false
    end
  end
end
