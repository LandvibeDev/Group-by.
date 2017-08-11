class CreateSelecteds < ActiveRecord::Migration[5.1]
  #user와 content 사이의 관계 content를 event 로 변환하기 위해 생성
  def change
    create_table :selecteds do |t|
      t.belongs_to :user
      t.belongs_to :content
      t.boolean :isEvent

      t.timestamps
    end
  end
end
