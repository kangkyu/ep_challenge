class AddTimePeriodToFetch < ActiveRecord::Migration
  def change
    add_column :fetches, :starting_at, :datetime
    add_column :fetches, :ending_at, :datetime
  end
end
