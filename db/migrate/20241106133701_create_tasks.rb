class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.bigint :user_id, null: false, index: true
      t.string :url, null: false
      t.string :uuid, limit: 36, null: false, index: {unique: true}
      t.integer :status, default: 0
      t.json :data

      t.timestamps
    end
  end
end
