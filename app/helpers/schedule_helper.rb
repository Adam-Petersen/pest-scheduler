module ScheduleHelper
  def overlap?(r1, r2)
    r1.first <= r2.last && r1.last >= r2.first
  end

  def order_range(order)
    start_mins = order.time.hour * 60 + order.time.min
    return (start_mins)..(start_mins + order.duration)
  end

end
