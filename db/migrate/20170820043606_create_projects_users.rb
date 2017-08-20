class CreateProjectsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :projects_users do |t|
      t.belongs_to :user, index: true, uniq: true
      t.belongs_to :project, index: true, uniq: true
    end
  end
end
