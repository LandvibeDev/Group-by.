class CreateSelecteds < ActiveRecord::Migration[5.1]
  #이 모델이 생성되면 content가 event로 저장 된 것이다
  def change
    create_table :selecteds do |t|
      t.belongs_to :user
      t.belongs_to :content

      t.timestamps
    end
  end
end
