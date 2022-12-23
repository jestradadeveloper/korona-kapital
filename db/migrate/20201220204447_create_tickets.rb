class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_enum "enum_status", %w[unsold held purchased refunded]

    create_table(:tickets) do |t|
      t.references(:concert, null: false, foreign_key: true)
      t.integer(:row)
      t.integer(:number)
      t.references(:user, null: true, foreign_key: true)
      t.enum :status, as: :enum_status
      t.references(:ticket_order)
      t.timestamps
    end
  end
end
