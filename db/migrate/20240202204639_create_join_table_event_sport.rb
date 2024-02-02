class CreateJoinTableEventSport < ActiveRecord::Migration[7.1]
  def change
    create_join_table :events, :sports do |t|
      t.index [:event_id, :sport_id]
      t.index [:sport_id, :event_id]
    end
  end
end
