class AdminController < ApplicationController
  before_action :authenticate_user!
  
  def preferences
    if current_user.has_role? :admin 
      @outstanding = Locale.where(status: false).order(created_at: 'DESC')
    else
      redirect_to root_path, notice: "Faça login antes de continuar."
    end
  end
end
