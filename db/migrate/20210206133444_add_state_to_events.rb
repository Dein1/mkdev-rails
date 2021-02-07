class AddStateToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :state, :string, default: 'pending', null: false
  end
end
