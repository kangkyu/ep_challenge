class AddFetchIdToEvents < ActiveRecord::Migration
  def change

    add_column :events, :fetch_id, :integer
  end
end
