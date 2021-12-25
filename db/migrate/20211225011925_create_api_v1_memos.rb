class CreateApiV1Memos < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_memos do |t|
      t.string :title
      t.text :memo
      t.string :created_by
      t.string :user_sub

      t.timestamps
    end
  end
end
