class CreateTeamEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :team_events do |t|
      t.belongs_to :project
      t.string :title
      t.text :content
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
