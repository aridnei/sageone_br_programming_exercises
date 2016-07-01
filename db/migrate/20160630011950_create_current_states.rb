class CreateCurrentStates < ActiveRecord::Migration
  def change
    create_table :current_states do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
