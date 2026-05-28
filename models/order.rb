class Order

  attr_accessor :id,
                :user_id,
                :status,
                :total_amount,
                :placed_at


  STATUS_MAP = {
    "pending"   => 1,
    "confirmed" => 2,
    "packed"    => 3,
    "shipped"   => 4,
    "delivered" => 5,
    "cancelled" => 6
  }.freeze

  def initialize(data)
    @id = data["id"]
    @user_id = data["user_id"]
    @status = data["status"]
    @total_amount = data["total_amount"]
    @placed_at = data["placed_at"]
  end

  def self.find_order_by_id(order_id)
    stmt = $db.prepare("select * from orders where id = ?")
    order = stmt.execute(order_id)&.first
    Order.new(order) unless order.nil?
  end

  def update_status(new_status)
    stmt = $db.prepare("update orders set status = ? where id = ?")
    stmt.execute(new_status, id)
    puts "Status updated successfully"
  rescue => e
    puts "#{e.message}"
  end 

  # Method 1: Focuses purely on filtering the allowed forward options
  def allowed_forward_statuses
    current_rank = STATUS_MAP[status.downcase]
    return {} if current_rank.nil?

    STATUS_MAP.select do |name, rank| 
      rank > current_rank && (name != "cancelled" || status.downcase != "delivered") 
    end
  end

  # Method 2: Focuses purely on formatting the filtered data for your terminal menu
  def get_next_statuses_from
    allowed_forward_statuses.map do |name, rank|
      "#{rank}) For #{name.capitalize}"
    end
  end

  def valid_status_input?(value)
    values = allowed_forward_statuses.values
    values.include?(value)
  end
end