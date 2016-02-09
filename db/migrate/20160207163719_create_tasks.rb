class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :priority
      t.datetime :deadline
      t.boolean :complete, default: false
      t.integer :duration
      t.boolean :favorite, default: false

      t.timestamps
    end
  end
end
