class CreateApiKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :api_keys do |t|
      t.integer :business_id, null: false
      t.string :access_token
      t.timestamps
    end
    add_index :api_keys, :business_id
  end
end
