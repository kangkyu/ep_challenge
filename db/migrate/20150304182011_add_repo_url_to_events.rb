class AddRepoUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :repo_url, :string
  end
end
