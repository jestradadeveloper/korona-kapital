
class BandsController < ApplicationController
  before_action :set_band, only: [:show, :edit, :update, :destroy]

  # GET /bands
  # GET /bands.json
  def index
    @bands = Band.all
  end

  # GET /bands/1
  # GET /bands/1.json
  def show
  end

  # GET /bands/new
  def new
    @band = Band.new
  end

  # GET /bands/1/edit
  def edit
  end

  # POST /bands
  # POST /bands.json
  def create
    @band = Band.new(band_params)

    respond_to do |format|
      if @band.save
        format.html do
          redirect_to(@band, notice: "Band was successfully created.")
        end

        format.json { render(:show, status: :created, location: @band) }
      else
        format.html { render(:new) }

        format.json do
          render(json: @band.errors, status: :unprocessable_entity)
        end
      end
    end
  end

  # PATCH/PUT /bands/1
  # PATCH/PUT /bands/1.json
  def update
    respond_to do |format|
      if @band.update(band_params)
        format.html do
          redirect_to(@band, notice: "Band was successfully updated.")
        end

        format.json { render(:show, status: :ok, location: @band) }
      else
        format.html { render(:edit) }

        format.json do
          render(json: @band.errors, status: :unprocessable_entity)
        end
      end
    end
  end

  # DELETE /bands/1
  # DELETE /bands/1.json
  def destroy
    @band.destroy

    respond_to do |format|
      format.html do
        redirect_to(bands_url, notice: "Band was successfully destroyed.")
      end

      format.json { head(:no_content) }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  private def set_band
    @band = Band.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  private def band_params
    params.require(:band).permit(:name, :description, :genre_tags)
  end
end
