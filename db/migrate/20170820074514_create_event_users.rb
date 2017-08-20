class CreateEventUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :event_users do |t|
      t.belongs_to :user, index: true, uniq: true
      t.belongs_to :team_event, index: true, uniq: true
    end
  end
end
