class AddAuthorToEvents < ActiveRecord::Migration[6.1]
  def change
    remove_reference :events, :user, foreign_key: true
    add_reference :events, :author, foreign_key: { to_table: :users }
  end
end
