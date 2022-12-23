class CreateTicketOrders < ActiveRecord::Migration[6.1]
  def change
    create_table(:ticket_orders) do |t|
      t.references(:concert, null: false, foreign_key: true)
      t.integer(:status, default: 0)
      t.integer(:count, default: 0)
      t.integer(:shopping_cart_id)
      t.timestamps
    end
  end
end
