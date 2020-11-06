class ScheduleController < ApplicationController
  include ScheduleHelper

  def index
    @technicians = Technician.all
    @blocks = []
    @breaks = []

    Technician.all.each do |tech|
      tech_orders = tech.work_orders.order(time: :asc)
      tech_orders.each_with_index do |work_order, i|
        order_wrapper = {}
        order_wrapper[:height] = "#{(100.0 * work_order.duration / 60.0).to_i.to_s}%"
        order_wrapper[:top] = "#{(100.0 * work_order.time.min / 60.0).to_i.to_s}%"
        order_wrapper[:work_order] = work_order
        order_wrapper[:hour] = work_order.time.hour
        order_wrapper[:min] = work_order.time.min
        order_wrapper[:start_time] = work_order.time.strftime("%H:%M")
        order_wrapper[:conflict] = false
        order_wrapper[:range] = order_range(work_order)
      
        if i > 0 && overlap?(order_wrapper[:range], order_range(tech_orders[i-1]))
          order_wrapper[:conflict] = true
          @blocks[tech_orders[i-1].time.hour][tech.id.to_s.to_sym][-1][:conflict] = true
        end

        @blocks[work_order.time.hour] = {} if @blocks[work_order.time.hour].nil?
        @blocks[work_order.time.hour][tech.id.to_s.to_sym] = [] if @blocks[work_order.time.hour][tech.id.to_s.to_sym].nil?
        @blocks[work_order.time.hour][tech.id.to_s.to_sym].push(order_wrapper)

        if i > 0 && i < tech_orders.length
          prev_order = tech_orders[i-1]
          break_start = prev_order.time + prev_order.duration.minutes
          break_duration = ((work_order.time - break_start) / 60.0).to_i
          if break_duration > 0
            p break_start
            p work_order.time
            p break_duration
            break_data = {}
            break_data[:height] = "#{(100.0 * break_duration / 60.0).to_i.to_s}%"
            break_data[:top] = "#{(100.0 * break_start.min / 60.0).to_i.to_s}%"
            break_data[:first_name] = prev_order.location.name
            break_data[:last_name] =  work_order.location.name
            break_data[:duration] = break_duration

            @breaks[break_start.hour] = {} if @breaks[break_start.hour].nil?
            @breaks[break_start.hour][tech.id.to_s.to_sym] = [] if @breaks[break_start.hour][tech.id.to_s.to_sym].nil?
            @breaks[break_start.hour][tech.id.to_s.to_sym].push(break_data)
          end
        end
      end
    end



      
    # p @blocks
    p @breaks

  end
end
