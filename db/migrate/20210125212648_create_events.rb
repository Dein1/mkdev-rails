class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description
      t.string :location
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :organizer_email
      t.string :organizer_telegram
      t.string :link

      t.timestamps
    end
  end
end
