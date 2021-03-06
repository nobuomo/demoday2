class CreateSubmitRequests < ActiveRecord::Migration
  def change
    create_table :submit_requests do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :work, index: true, foreign_key: true, null: false
      t.text :memo
      t.integer :request_user_id, null: false
      t.integer :status, default: 1

      t.timestamps null: false
    end
  end
end
