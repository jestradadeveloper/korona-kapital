
class TicketOrdersController < ApplicationController
  before_action :set_ticket_order, only: [:show, :edit, :update, :destroy]

  # GET /ticket_orders
  # GET /ticket_orders.json
  def index
    @ticket_orders = TicketOrder.all
  end

  # GET /ticket_orders/1
  # GET /ticket_orders/1.json
  def show
  end

  # GET /ticket_orders/new
  def new
    @ticket_order = TicketOrder.new
  end

  # GET /ticket_orders/1/edit
  def edit
  end

  # POST /ticket_orders
  # POST /ticket_orders.json
  def create
    @ticket_order = TicketOrder.new(ticket_order_params)

    respond_to do |format|
      if @ticket_order.save
        format.html do
          redirect_to(@ticket_order, notice: "Ticket order was successfully created.")
        end

        format.json { render(:show, status: :created, location: @ticket_order) }
      else
        format.html { render(:new) }

        format.json do
          render(json: @ticket_order.errors, status: :unprocessable_entity)
        end
      end
    end
  end

  # PATCH/PUT /ticket_orders/1
  # PATCH/PUT /ticket_orders/1.json
  def update
    respond_to do |format|
      if @ticket_order.update(ticket_order_params)
        format.html do
          redirect_to(@ticket_order, notice: "Ticket order was successfully updated.")
        end

        format.json { render(:show, status: :ok, location: @ticket_order) }
      else
        format.html { render(:edit) }

        format.json do
          render(json: @ticket_order.errors, status: :unprocessable_entity)
        end
      end
    end
  end

  # DELETE /ticket_orders/1
  # DELETE /ticket_orders/1.json
  def destroy
    @ticket_order.destroy

    respond_to do |format|
      format.html do
        redirect_to(
          ticket_orders_url,
          notice: "Ticket order was successfully destroyed."
        )
      end

      format.json { head(:no_content) }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  private def set_ticket_order
    @ticket_order = TicketOrder.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  private def ticket_order_params
    params.require(:ticket_order).permit(:concert_id)
  end
end
