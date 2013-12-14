class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :name
      t.string :provider
      t.string :uid
      t.string :photo

      t.timestamps
    end
  end
end
