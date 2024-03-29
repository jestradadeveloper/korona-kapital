
class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html do
          redirect_to(@ticket, notice: "Ticket was successfully created.")
        end

        format.json { render(:show, status: :created, location: @ticket) }
      else
        format.html { render(:new) }

        format.json do
          render(json: @ticket.errors, status: :unprocessable_entity)
        end
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    @ticket.toggle_for(current_user)
    redirect_to(@ticket.concert)
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html do
        redirect_to(tickets_url, notice: "Ticket was successfully destroyed.")
      end

      format.json { head(:no_content) }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  private def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  private def ticket_params
    params.require(:ticket).permit(
      :concert_id,
      :row,
      :number,
      :user_id,
      :status
    )
  end
end
