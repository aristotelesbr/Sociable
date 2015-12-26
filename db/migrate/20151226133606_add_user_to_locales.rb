class AddUserToLocales < ActiveRecord::Migration
  def change
    add_reference :locales, :user, index: true, foreign_key: true
  end
end
