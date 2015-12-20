class AddStatusFromLocale < ActiveRecord::Migration
  def change
    add_column :locales, :status, :boolean
  end
end
