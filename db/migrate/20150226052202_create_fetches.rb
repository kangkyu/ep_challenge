class CreateFetches < ActiveRecord::Migration
  def change
    create_table :fetches do |t|
      t.string :get_info

      t.timestamps null: false
    end
  end
end
