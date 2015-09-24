class User < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
    end    
  end
end
