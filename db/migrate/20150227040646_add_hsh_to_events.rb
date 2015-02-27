class AddHshToEvents < ActiveRecord::Migration
  def change
    add_column :events, :hsh, :text
  end
end
