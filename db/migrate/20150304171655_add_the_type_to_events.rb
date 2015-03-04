class AddTheTypeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :the_type, :string
  end
end
