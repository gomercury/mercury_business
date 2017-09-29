class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
    	t.string :name, null: false
    	t.string :thumbnail, null: false
    	t.string :email, null: false
    	t.string :phone, null: false
    	t.string :address, null: false
    	t.decimal :longitude, null: false
    	t.decimal :latitude, null: false
    	t.text :description, null: false
    	t.string :facebook
    	t.string :instagram
    	t.string :yelp
    	t.string :twitter
      t.timestamps
    end
  end
end
