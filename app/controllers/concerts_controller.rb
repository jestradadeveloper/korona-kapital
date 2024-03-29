class ConcertsController < ApplicationController
  before_action :set_concert, only: [:show, :edit, :update, :destroy]

  # GET /concerts
  # GET /concerts.json
  def index
    @concerts = Concert.all
  end

  # GET /concerts/1
  # GET /concerts/1.json
  def show
    if params[:inline]
      render(@concert)
    end
  end

  # GET /concerts/new
  def new
    @concert = Concert.new
  end

  # GET /concerts/1/edit
  def edit
  end

  # POST /concerts
  # POST /concerts.json
  def create
    @concert = Concert.new(concert_params)

    respond_to do |format|
      if @concert.save
        format.html do
          redirect_to(@concert, notice: "Concert was successfully created.")
        end

        format.json { render(:show, status: :created, location: @concert) }
      else
        format.html { render(:new) }

        format.json do
          render(json: @concert.errors, status: :unprocessable_entity)
        end
      end
    end
  end

  # PATCH/PUT /concerts/1
  # PATCH/PUT /concerts/1.json
  def update
    respond_to do |format|
      if @concert.update(concert_params)
        format.html do
          render(@concert)
          # redirect_to(@concert, notice: "Concert was successfully updated.")
        end

        format.json { render(:show, status: :ok, location: @concert) }
      else
        format.html { render(:edit) }

        format.json do
          render(json: @concert.errors, status: :unprocessable_entity)
        end
      end
    end
  end

  # DELETE /concerts/1
  # DELETE /concerts/1.json
  def destroy
    @concert.destroy

    respond_to do |format|
      format.html do
        redirect_to(concerts_url, notice: "Concert was successfully destroyed.")
      end

      format.json { head(:no_content) }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  private def set_concert
    @concert = Concert.includes(:tickets).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  private def concert_params
    params.require(:concert).permit(
      :name,
      :description,
      :start_time,
      :venue_id,
      :genre_tags,
      :ilk,
      :access
    )
  end
end
