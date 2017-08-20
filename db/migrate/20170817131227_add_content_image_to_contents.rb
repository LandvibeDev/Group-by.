class AddContentImageToContents < ActiveRecord::Migration[5.1]
  def change
    add_column :contents, :image, :string
  end
end
