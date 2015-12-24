class AdminController < ApplicationController
  def preferences
    @outstanding = Locale.where(status: false).order(created_at: 'DESC')
  end
end
