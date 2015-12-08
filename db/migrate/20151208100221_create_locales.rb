class CreateLocales < ActiveRecord::Migration
  def change
    create_table :locales do |t|
      t.string :title
      t.text :description
      t.string :state
      t.string :street
      t.string :number
      t.string :zip
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
