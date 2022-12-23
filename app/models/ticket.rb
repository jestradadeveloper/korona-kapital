
# == Schema Information
#
# Table name: tickets
#
#  id              :bigint           not null, primary key
#  number          :integer
#  row             :integer
#  status          :enum
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  concert_id      :bigint           not null
#  ticket_order_id :bigint
#  user_id         :bigint
#
class Ticket < ApplicationRecord
  belongs_to :concert
  belongs_to :user, optional: true
  belongs_to :ticket_order, optional: true

  enum(
    status: {
      unsold: "unsold",
      held: "held",
      purchased: "purchased",
      refunded: "refunded"
    }
  )

  def toggle_for(user)
    return unless user
    return if self.user && self.user != user
    case status
    when "unsold"
      update(status: "held", user: user)
    when "held"
      update(status: "unsold", user: user)
    end
  end

  def color_for(user)
    case status
    when "unsold" then "bg-white"
    when "held"
      self.user == user ? "bg-yellow-600" : "bg-red-500"
    when "purchased"
      self.user == user ? "bg-green-600" : "bg-red-500"
    end
  end
end
