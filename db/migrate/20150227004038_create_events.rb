class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :time_created
      t.string :repo_name

      t.timestamps null: false
    end
  end
end
