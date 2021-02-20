class CreateReads < ActiveRecord::Migration[6.0]
  def change
    create_table :reads do |t|
      t.references :user, null: false
      t.references :information, null: false
      t.timestamps
    end
  end
end
