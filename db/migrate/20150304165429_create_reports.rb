class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.datetime :starting_at
      t.datetime :ending_at

      t.timestamps null: false
    end
  end
end
