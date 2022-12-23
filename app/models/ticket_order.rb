
# == Schema Information
#
# Table name: ticket_orders
#
#  id               :bigint           not null, primary key
#  count            :integer          default(0)
#  status           :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  concert_id       :bigint           not null
#  shopping_cart_id :integer
#
class TicketOrder < ApplicationRecord
  belongs_to :concert
end
