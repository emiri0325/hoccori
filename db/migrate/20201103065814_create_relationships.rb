class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :users }
                                        # usersテーブルを参照させたい

      t.timestamps
      
      # user_id と follow_id のペアで重複するものが保存されない設定
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
