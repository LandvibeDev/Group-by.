class CreateTeamEventsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_events_users do |t|
      t.belongs_to :user, index: true, uniq: true
      t.belongs_to :team_event, index: true, uniq: true
      t.boolean :complete
      t.timestamps
    end
  end
end
