module ActiveAdmin
  module OrdersHelper
    def color_for_status(status)
      case status
      when 'Pending'    then :gray
      when 'Complete'   then :green
      when 'Processing' then :orange
      end
    end
  end
end
