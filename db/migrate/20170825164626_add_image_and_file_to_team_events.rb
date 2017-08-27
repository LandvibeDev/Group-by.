class AddImageAndFileToTeamEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :team_events, :teamEventImage, :string
    add_column :team_events, :teamEventFile, :string
  end
end
