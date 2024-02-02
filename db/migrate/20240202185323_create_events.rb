class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.integer :guests

      t.timestamps
    end
  end
end
