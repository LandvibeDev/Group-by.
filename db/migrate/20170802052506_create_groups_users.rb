class CreateGroupsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :groups_users do |t|
      t.belongs_to :user, index: true, uniq: true
      t.belongs_to :group, index: true, uniq: true
    end
  end
end
