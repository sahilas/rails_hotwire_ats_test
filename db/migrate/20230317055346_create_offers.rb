class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers, id: :uuid do |t|
      t.string :title
      t.string :status
      t.string :offer_type
      t.string :location
      t.references :profile, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :offers, :status
    add_index :offers, :offer_type
  end
end
