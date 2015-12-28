class LocalesController < ApplicationController
  before_action :set_locale, only: [:show, :edit, :update, :destroy]
  
  # GET /locales
  # GET /locales.json
  def index
    @locales = Locale.find_status
    @categories = Category.all
    @hash = Gmaps4rails.build_markers(@locales) do |locale, marker|
      marker.lat locale.latitude
      marker.lng locale.longitude
      marker.infowindow locale.title
      if locale.category_id == 1
        marker.picture({
          url: "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png",
          width:  32,
          height: 32})
      elsif locale.category_id == 2
        marker.picture({
          url: "http://maps.google.com/mapfiles/ms/icons/purple-dot.png",
          width:  32,
          height: 32})        
      end
    end
  end    

  # GET /locales/1
  # GET /locales/1.json
  def show
    if @locale.user_id == current_user.id or current_user.has_role? :admin
      @locale
    else
      redirect_to root_path, notice: "Você não tem autorização para ver isso"
    end
  end

  # GET /locales/new
  def new
    @locale = current_user.locales.build
  end

  # GET /locales/1/edit
  def edit
  end

  # POST /locales
  # POST /locales.json
  def create
    @locale = current_user.locales.build(locale_params)
    respond_to do |format|
      if @locale.save
        format.html { redirect_to @locale, notice: 'Locale was successfully created.' }
        format.json { render :show, status: :created, location: @locale }
      else
        format.html { render :new }
        format.json { render json: @locale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locales/1
  # PATCH/PUT /locales/1.json
  def update
    respond_to do |format|
      if @locale.update(locale_params)
        format.html { redirect_to @locale, notice: 'Locale was successfully updated.' }
        format.json { render :show, status: :ok, location: @locale }
      else
        format.html { render :edit }
        format.json { render json: @locale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locales/1
  # DELETE /locales/1.json
  def destroy
    @locale.destroy
    respond_to do |format|
      format.html { redirect_to locales_url, notice: 'Locale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_locale
      @locale = Locale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def locale_params
      params.require(:locale).permit(:title, :description,
        :state, :status, :city, :latitude, :longitude, :street, :number, :zip, :category_id)
    end
end
